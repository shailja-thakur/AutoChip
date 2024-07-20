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

	// 128-entry PHT with 2-bit saturating counters
	reg [1:0] PHT [127:0];
	integer i;

	// 7-bit global branch history register (GHR)
	reg [6:0] GHR;

	// Reset and initial conditions
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01;  // Weakly not taken state
			end
			GHR <= 7'b0;
		end else if (train_valid) begin
			// Update the PHT for training
			if (train_taken) begin
				if (PHT[train_pc ^ train_history] != 2'b11)
					PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
			end else begin
				if (PHT[train_pc ^ train_history] != 2'b00)
					PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
			end

			// Recover the GHR if there was a misprediction
			if (train_mispredicted) begin
				GHR <= {GHR[5:0], train_taken};
			end else begin
				// Update the GHR for the next state
				GHR <= {GHR[5:0], train_taken};
			end
		end
	end

	// Predict branch direction
	always @(posedge clk) begin
		if (predict_valid) begin
			// Compute the index for the PHT using XOR
			predict_history <= GHR;
			case (PHT[predict_pc ^ GHR])
				2'b00: predict_taken <= 0;
				2'b01: predict_taken <= 0;
				2'b10: predict_taken <= 1;
				2'b11: predict_taken <= 1;
			endcase

			// Update the GHR for the next state (speculative)
			if (!train_valid) begin
				GHR <= {GHR[5:0], predict_taken};
			end
		end
	end

endmodule
