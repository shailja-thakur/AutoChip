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

	reg [6:0] gbhr; // Global Branch History Register
	reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters

	integer i;
	// Asynchronous reset for global branch history register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			gbhr <= 7'd0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Initialize all counters to weakly not taken
			end
		end else if (train_valid) begin
			if (train_mispredicted) begin
				gbhr <= {train_history[6:1], train_taken}; // Recovering the history if mispredicted
			end else begin
				gbhr <= {gbhr[5:0], train_taken}; // Update history with the actual outcome
			end

			// Update PHT with actual branch outcome
			case (PHT[train_pc ^ train_history])
				2'b00: PHT[train_pc ^ train_history] <= train_taken ? 2'b01 : 2'b00;
				2'b01: PHT[train_pc ^ train_history] <= train_taken ? 2'b10 : 2'b00;
				2'b10: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b01;
				2'b11: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b10;
			endcase

		end else if (predict_valid) begin
			gbhr <= {gbhr[5:0], predict_taken}; // Update history with the predicted outcome
		end
	end

	// Predict the branch outcome
	always @(*) begin
		predict_history = gbhr;
		if (predict_valid) begin
			case (PHT[predict_pc ^ gbhr])
				2'b00, 2'b01: predict_taken = 0; // Predict Not Taken
				2'b10, 2'b11: predict_taken = 1; // Predict Taken
			endcase
		end else begin
			predict_taken = 0;
		end
	end
endmodule
