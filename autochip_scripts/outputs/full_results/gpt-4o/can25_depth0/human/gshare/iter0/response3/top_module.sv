module top_module(
	input clk,
	input areset, 

	input predict_valid,
	input [6:0] predict_pc,
	output reg predict_taken, 
	output reg [6:0] predict_history,

	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);
	// 128-entry table of 2-bit saturating counters
	reg [1:0] PHT [127:0];
	// 7-bit global branch history register
	reg [6:0] global_history;

	// Hashing function: XOR pc with global history to get the index for the PHT
	wire [6:0] predict_index = predict_pc ^ global_history;
	wire [6:0] train_index = train_pc ^ train_history;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset all PHT entries and global history
			integer i;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Initialize to weakly not taken
			end
			global_history <= 7'b0;
		end else begin
			if (train_valid) begin
				// Update the PHT entry for training
				case ({train_taken, PHT[train_index]})
					3'b000: PHT[train_index] <= 2'b00;
					3'b001: PHT[train_index] <= 2'b00;
					3'b010: PHT[train_index] <= 2'b00;
					3'b011: PHT[train_index] <= 2'b10;
					3'b100: PHT[train_index] <= 2'b01;
					3'b101: PHT[train_index] <= 2'b11;
					3'b110: PHT[train_index] <= 2'b11;
					3'b111: PHT[train_index] <= 2'b11;
					default: PHT[train_index] <= PHT[train_index];
				endcase

				if (train_mispredicted) begin
					global_history <= train_history; // Recover the branch history register
				end else begin
					// Update the global history register for actual outcome
					global_history <= {global_history[5:0], train_taken};
				end
			end
		end
	end

	always @(*) begin
		if (predict_valid) begin
			// Making prediction based on current PHT entry
			predict_taken = PHT[predict_index][1];
			predict_history = global_history;
		end else begin
			predict_taken = 1'b0;
			predict_history = 7'b0;
		end
	end

	always @(posedge clk) begin
		if (predict_valid && !train_valid) begin
			// Update global history register for predicted branch
			global_history <= {global_history[5:0], predict_taken};
		end
	end
endmodule
