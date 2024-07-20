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

	// Define the 128-entry Pattern History Table (PHT) with 2-bit saturating counters
	reg [1:0] PHT [127:0];
	integer i;

	// Define the 7-bit global branch history register
	reg [6:0] global_history;

	// XOR to get the index from PC and history
	wire [6:0] predict_index = predict_pc ^ global_history;
	wire [6:0] train_index = train_pc ^ train_history;

	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Clear PHT and global history on reset
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Weakly not taken
			end
		end
		else begin
			// Update the branch history register and PHT when training
			if (train_valid) begin
				if (train_taken) begin
					if (PHT[train_index] != 2'b11) begin
						PHT[train_index] <= PHT[train_index] + 1;
					end
				end
				else begin
					if (PHT[train_index] != 2'b00) begin
						PHT[train_index] <= PHT[train_index] - 1;
					end
				end

				if (train_mispredicted) begin
					global_history <= train_history;
				end
				else begin
					global_history <= {global_history[5:0], train_taken};
				end
			end
			else if (predict_valid) begin
				global_history <= {global_history[5:0], PHT[predict_index][1]};
			end
		end
	end

	// Prediction logic
	always @(*) begin
		if (areset) begin
			predict_taken = 0;
			predict_history = 7'b0;
		end
		else begin
			predict_history = global_history;
			if (predict_valid) begin
				predict_taken = PHT[predict_index] >= 2'b10;
			end
			else begin
				predict_taken = 0;
			end
		end
	end

endmodule
