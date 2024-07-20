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

	// Global branch history register
	reg [6:0] global_history;

	// Pattern History Table (PHT) with 128 entries of 2-bit counters
	reg [1:0] PHT [0:127];

	// Predict index
	wire [6:0] predict_index;

	// Calculate the index using XOR of pc and the global history
	assign predict_index = predict_pc ^ global_history;

	// PHT counter value for prediction
	reg [1:0] PHT_entry;

	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
		end else begin
			if (train_valid) begin
				// Calculate training index
				wire [6:0] train_index = train_pc ^ train_history;
				
				// Train PHT
				if (train_taken) begin
					if (PHT[train_index] < 2'b11)
						PHT[train_index] <= PHT[train_index] + 1;
				end else begin
					if (PHT[train_index] > 2'b00)
						PHT[train_index] <= PHT[train_index] - 1;
				end
				
				// Update global history
				if (train_mispredicted)
					global_history <= train_history;
				else
					global_history <= {global_history[5:0], train_taken};
			end else if (predict_valid) begin
				// Update global history for prediction
				global_history <= {global_history[5:0], PHT[predict_index][1]};
			end
		end
	end

	always @ (*) begin
		// Prediction path
		if (predict_valid) begin
			PHT_entry = PHT[predict_index];
			predict_taken = PHT_entry[1];
			predict_history = global_history;
		end else begin
			predict_taken = 0;
			predict_history = 7'b0;
		end
	end

endmodule
