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
	
	// 128-entry table of two-bit saturating counters
	reg [1:0] PHT [0:127];
	reg [6:0] GHR;  // Global History Register
	integer i;
	
	initial begin
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] = 2'b01;  // Initialize to weakly not taken
		end
		GHR = 7'b0;
	end
	
	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			GHR <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01;  // Reset to weakly not taken
			end
		end else begin
			if (train_valid) begin
				// Compute index
				reg [6:0] index;
				index = train_pc ^ train_history;

				// Train PHT
				if (train_taken) begin
					if (PHT[index] != 2'b11)
						PHT[index] <= PHT[index] + 2'b01;  // Increment saturating counter
				end else begin
					if (PHT[index] != 2'b00)
						PHT[index] <= PHT[index] - 2'b01;  // Decrement saturating counter
				end

				// Recover GHR if needed
				if (train_mispredicted) begin
					GHR <= train_history;
				end else begin
					// Update GHR with actual taken/not taken outcome
					GHR <= {GHR[5:0], train_taken};
				end
			end else if (predict_valid) begin
				// Update GHR with predicted outcome during prediction stage
				GHR <= {GHR[5:0], predict_taken};
			end
		end
	end

	always @(*) begin
		// Compute index
		reg [6:0] index;
		index = predict_pc ^ GHR;

		// Predict based on PHT value
		predict_taken = (PHT[index] >= 2'b10);
		predict_history = GHR;
	end
	
endmodule
