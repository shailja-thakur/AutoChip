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
	reg [1:0] PHT[127:0];
	
	// 7-bit global branch history register
	reg [6:0] global_history;
	reg [1:0] PHT_out;

	// Calculate the indexes by XORing the PC and the history
	wire [6:0] predict_index = predict_pc ^ global_history;
	wire [6:0] train_index = train_pc ^ train_history;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			integer i;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Weakly taken (01) as the initial state
			end
			global_history <= 7'b0;
		end else begin
			// Perform training if valid
			if (train_valid) begin
				// Training the PHT entry
				if (train_taken) begin
					if (PHT[train_index] < 2'b11) PHT[train_index] <= PHT[train_index] + 1;
				end else begin
					if (PHT[train_index] > 2'b00) PHT[train_index] <= PHT[train_index] - 1;
				end

				// Update the global history register after considering misprediction
				if (train_mispredicted) begin
					global_history <= {train_history[5:0], train_taken};
				end else begin
					global_history <= {global_history[5:0], train_taken};
				end
			end else if (predict_valid) begin
				// Update the global history register with the prediction
				global_history <= {global_history[5:0], PHT[predict_index][1]};
			end
		end
	end

	always @(*) begin
		PHT_out = PHT[predict_index];
		predict_taken = PHT_out[1];
		predict_history = global_history;
	end

endmodule
