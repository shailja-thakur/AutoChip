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

	// Parameter definitions
	localparam PHT_SIZE = 128;
	localparam HISTORY_WIDTH = 7;

	// Two-bit saturating counter states
	localparam STRONGLY_NOT_TAKEN = 2'b00;
	localparam WEAKLY_NOT_TAKEN = 2'b01;
	localparam WEAKLY_TAKEN = 2'b10;
	localparam STRONGLY_TAKEN = 2'b11;

	// Pattern History Table (PHT)
	reg [1:0] PHT [0:PHT_SIZE-1];
	// Global Branch History Register
	reg [HISTORY_WIDTH-1:0] GHR;

	integer i;

	// Asynchronous reset
	always @(posedge areset or posedge clk) begin
		if (areset) begin
			// Reset the PHT and the GHR
			for (i = 0; i < PHT_SIZE; i = i + 1) begin
				PHT[i] <= WEAKLY_NOT_TAKEN;
			end
			GHR <= 0;
		end else begin
			if (train_valid) begin
				// Compute the index for the PHT based on train_pc and train_history
				integer train_index;
				train_index = train_pc ^ train_history;

				// Update the PHT based on the actual branch outcome
				case (PHT[train_index])
					STRONGLY_NOT_TAKEN: PHT[train_index] <= train_taken ? WEAKLY_NOT_TAKEN : STRONGLY_NOT_TAKEN;
					WEAKLY_NOT_TAKEN: PHT[train_index] <= train_taken ? WEAKLY_TAKEN : STRONGLY_NOT_TAKEN;
					WEAKLY_TAKEN: PHT[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_NOT_TAKEN;
					STRONGLY_TAKEN: PHT[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_TAKEN;
				endcase

				// If there was a misprediction, recover the GHR
				if (train_mispredicted) begin
					GHR <= train_history;
				end else begin
					// Update the GHR with the actual branch outcome
					GHR <= {GHR[HISTORY_WIDTH-2:0], train_taken};
				end

			end else if (predict_valid) begin
				// Compute the index for the PHT based on predict_pc and GHR
				integer predict_index;
				predict_index = predict_pc ^ GHR;

				// Predict the branch direction based on the PHT state
				case (PHT[predict_index])
					STRONGLY_NOT_TAKEN,
					WEAKLY_NOT_TAKEN: predict_taken <= 0;
					WEAKLY_TAKEN,
					STRONGLY_TAKEN: predict_taken <= 1;
				endcase

				// Provide the branch history register used to make the prediction
				predict_history <= GHR;
				
				// Update the GHR assuming the prediction was taken
				GHR <= {GHR[HISTORY_WIDTH-2:0], predict_taken};
			end
		end
	end

endmodule
