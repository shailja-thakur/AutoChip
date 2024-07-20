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

	reg [1:0] PHT [0:127];  // Pattern History Table with 2-bit counters
	reg [6:0] GHR;  // Global History Register
	wire [6:0] predict_index, train_index;
	integer i;

	// Calculate the indexes by hashing PC and GHR
	assign predict_index = predict_pc ^ GHR;
	assign train_index = train_pc ^ train_history;

	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset all the counters in PHT and GHR
			GHR <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01;  // Initialize to weakly not taken
			end
		end else begin
			// Update the PHT and GHR on the rising edge of the clock
			if (train_valid) begin
				if (train_taken) begin
					if (PHT[train_index] < 2'b11)
						PHT[train_index] <= PHT[train_index] + 2'b01;  // Increment counter
				end else begin
					if (PHT[train_index] > 2'b00)
						PHT[train_index] <= PHT[train_index] - 2'b01;  // Decrement counter
				end

				if (train_mispredicted) begin
					// Recover the GHR to the state after the mispredicting branch
					GHR <= (train_history << 1) | train_taken;
				end
			end
			// Update GHR for predicted branch if no training is happening
			else if (predict_valid) begin
				GHR <= (GHR << 1) | predict_taken;
			end
		end
	end

	// Predict the branch direction
	always @(*) begin
		predict_history = GHR;
		if (PHT[predict_index] >= 2'b10)
			predict_taken = 1;
		else
			predict_taken = 0;
	end

endmodule
