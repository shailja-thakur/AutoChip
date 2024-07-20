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

	// Define the Pattern History Table (PHT) with 128 entries of 2-bit saturating counters
	reg [1:0] PHT [0:127];
	
	// Define the 7-bit Global History Register
	reg [6:0] GHR;

	integer i;

	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			GHR <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Initialize to weakly not taken (01)
			end
		end else begin
			// Prediction logic
			if (predict_valid) begin
				// Calculate index using XOR of PC and GHR
				predict_history <= GHR;
				predict_taken <= (PHT[predict_pc ^ GHR] >= 2'b10); // taken if PHT count is 2 or 3
			end
			
			// Training logic
			if (train_valid) begin
				// Find the PHT index using XOR of PC and history at misprediction point
				reg [6:0] index = train_pc ^ ((train_mispredicted) ? train_history : GHR);
				// Update the PHT based on training outcome
				if (train_taken) begin
					if (PHT[index] < 2'b11) begin
						PHT[index] <= PHT[index] + 1;
					end
				end else begin
					if (PHT[index] > 2'b00) begin
						PHT[index] <= PHT[index] - 1;
					end
				end
				
				// Update GHR
				if (train_mispredicted) begin
					GHR <= {train_history[5:0], train_taken};
				end else begin
					GHR <= {GHR[5:0], predict_taken};
				end
			end
		end
	end

endmodule
