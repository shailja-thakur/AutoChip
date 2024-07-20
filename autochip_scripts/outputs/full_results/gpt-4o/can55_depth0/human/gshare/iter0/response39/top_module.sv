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

	// Define the PHT with 128 entries of 2-bit counters
	reg [1:0] PHT [0:127];
	// Global History Register
	reg [6:0] GHR;

	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			integer i;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01;  // weakly not taken
			end
			GHR <= 7'b0;
		end
		else begin
			// Training logic
			if (train_valid) begin
				integer index;
				index = train_pc ^ train_history; // Compute index using XOR
				// Update the PHT entry based on training outcome
				if (train_taken) begin
					if (PHT[index] < 2'b11) PHT[index] <= PHT[index] + 1; // Increment counter
				end else begin
					if (PHT[index] > 2'b00) PHT[index] <= PHT[index] - 1; // Decrement counter
				end
				// Recover global history register if mispredicted
				if (train_mispredicted) begin
					GHR <= train_history;
				end else begin
					// Update GHR with actual outcome
					GHR <= {GHR[5:0], train_taken};
				end
			end
		end
	end

	// Prediction logic
	always @(posedge clk) begin
		if (predict_valid) begin
			integer index;
			index = predict_pc ^ GHR; // Compute index using XOR
			// Output the prediction based on PHT entry
			predict_taken <= (PHT[index] >= 2'b10);
			// Output the current history used for prediction
			predict_history <= GHR;
			// Update GHR with predicted outcome
			GHR <= {GHR[5:0], (PHT[index] >= 2'b10)};
		end
	end

endmodule
