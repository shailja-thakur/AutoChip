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
	
	// Pattern History Table (PHT) with 128 entries of 2-bit counters
	reg [1:0] PHT [127:0];
	integer i;

	// Global 7-bit branch history register
	reg [6:0] global_history;
	
	// Initialize the branch predictor on reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Weakly not taken state
			end
		end else if (predict_valid) begin
			// Update global history with prediction
			global_history <= {global_history[5:0], predict_taken};
		end else if (train_valid) begin
			if (train_mispredicted) begin
				// Recover the global history
				global_history <= {train_history[5:0], train_taken};
			end else begin
				global_history <= {global_history[5:0], train_taken};
			end
		end
	end
	
	// Prediction logic
	always @(*) begin
		integer index;
		index = predict_pc ^ global_history;
		predict_taken = PHT[index][1]; // Taken if counter MSB is 1
		predict_history = global_history;
		if (train_valid) begin
			index = train_pc ^ train_history;
		end
	end
	
	// Training logic
	always @(posedge clk) begin
		if (train_valid) begin
			integer index;
			index = train_pc ^ train_history;
			if (train_taken) begin
				if (PHT[index] < 2'b11) begin
					PHT[index] <= PHT[index] + 1;
				end
			end else begin
				if (PHT[index] > 2'b00) begin
					PHT[index] <= PHT[index] - 1;
				end
			end
		end
	end

endmodule
