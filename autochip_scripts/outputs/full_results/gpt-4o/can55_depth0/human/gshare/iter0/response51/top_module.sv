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
	reg [1:0] PHT[127:0];
	reg [6:0] global_history;
	
	// Saturating counter states
	localparam STRONGLY_NOT_TAKEN = 2'b00;
	localparam WEAKLY_NOT_TAKEN   = 2'b01;
	localparam WEAKLY_TAKEN       = 2'b10;
	localparam STRONGLY_TAKEN     = 2'b11;

	// Reset the table and global history
	integer i;
	always @(posedge areset) begin
		global_history <= 7'b0;
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] <= WEAKLY_NOT_TAKEN;
		end
	end

	// Predict branch direction
	always @(posedge clk) begin
		if (predict_valid && !train_valid) begin
			predict_history <= global_history;
			predict_taken <= (PHT[predict_pc ^ global_history] >= WEAKLY_TAKEN);
			global_history <= {global_history[5:0], predict_taken}; // Update history for the predicted branch
		end
	end

	// Train the branch predictor
	always @(posedge clk) begin
		if (train_valid) begin
			// Get the index for the training entry
			if (train_taken) begin
				if (PHT[train_pc ^ train_history] != STRONGLY_TAKEN) begin
					PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
				end
			end else begin
				if (PHT[train_pc ^ train_history] != STRONGLY_NOT_TAKEN) begin
					PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
				end
			end
		
			// Recover global history register if there was a misprediction
			if (train_mispredicted) begin
				global_history <= {train_history[5:0], train_taken}; // Rollback to the correct state
			end else begin
				global_history <= {global_history[5:0], train_taken}; // Update history for the actual branch
			end
		end
	end

endmodule
