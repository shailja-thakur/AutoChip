module top_module(
	input clk,
	input areset, 

	input predict_valid,
	input [6:0] predict_pc,
	output predict_taken, 
	output [6:0] predict_history,

	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);

	reg [2:0] PHT [0:127];  // Pattern History Table

	reg [6:0] GHR;  // Global History Register
	
	reg predict_taken;
	reg [6:0] predict_history;
	
	// Mux for selecting either the predicted or trained history
	wire [6:0] history_select;
	assign history_select = (train_valid) ? train_history : predict_history;
	
	// Mux for selecting the correct entry in the PHT
	wire [6:0] index_select;
	assign index_select = predict_pc ^ GHR;
	
	// Output the predicted branch direction and history
	always @(*) begin
		if (predict_valid) begin
			predict_taken = (PHT[index_select] >= 2);
			predict_history = history_select;
		end
	end
	
	// Update the global history register for the predicted branch
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			GHR <= 0;
		end else if (predict_valid) begin
			GHR <= {GHR[5:0], predict_taken};
		end
	end

	// Train the branch predictor with the actual outcomes
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			PHT <= 0;
		end else if (train_valid) begin
			PHT[index_select] <= PHT[index_select] + ((train_taken == train_mispredicted) ? 0 : ((train_taken) ? 1 : -1));
		end
	end
	
endmodule
