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

	// Internal definitions
	reg [1:0] PHT [0:127]; // Pattern History Table: 128 entries of 2-bit counters

	reg [6:0] global_history; // 7-bit global branch history register

	integer i;

	// Asynchronous reset
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Initialize PHT counters to weakly not taken (01)
			end
		end else begin
			if (train_valid) begin
				// Calculate index for training
				reg [6:0] train_index;
				train_index = train_pc ^ train_history;

				// Update PHT based on actual branch outcome
				if (train_taken) begin
					if (PHT[train_index] < 2'b11) begin
						PHT[train_index] <= PHT[train_index] + 1;
					end
				end else begin
					if (PHT[train_index] > 2'b00) begin
						PHT[train_index] <= PHT[train_index] - 1;
					end
				end

				// If the branch was mispredicted, recover the branch history register
				if (train_mispredicted) begin
					global_history <= {train_history[5:0], train_taken}; // Shift the history register
				end else begin
					global_history <= {global_history[5:0], train_taken}; // Update the global history register
				end
			end else if (predict_valid) begin
				// Calculate index for prediction
				reg [6:0] predict_index;
				predict_index = predict_pc ^ global_history;

				// Predict branch direction
				predict_taken = (PHT[predict_index] >= 2'b10); // Taken if counter is >= 2

				// Provide the history register used for the prediction
				predict_history = global_history;

				// Update the global history register
				global_history <= {global_history[5:0], predict_taken}; // Shift in the prediction result
			end
		end
	end
endmodule
