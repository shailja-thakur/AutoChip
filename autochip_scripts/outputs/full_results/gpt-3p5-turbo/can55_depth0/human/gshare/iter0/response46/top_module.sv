module top_module(
	input clk,
	input areset, 

	// Prediction interface
	input predict_valid,
	input [6:0] predict_pc,
	output reg predict_taken = 0, 
	output reg [6:0] predict_history = 0,

	// Training interface
	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);

	// Branch history register
	reg [6:0] branch_history;

	// Pattern History Table (PHT) - 128 entries, each with 2-bit saturating counters
	reg [1:0] pht [0:127];
	
	// Hashing function
	function [6:0] hash;
		input [6:0] pc, global_history;
		begin
			hash = pc ^ global_history;
		end
	endfunction
	
	// Fetch Stage
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			predict_taken <= 0;
			predict_history <= 0;
		end else if (predict_valid) begin
			predict_taken <= pht[hash(predict_pc, branch_history)][1];
			predict_history <= branch_history;
		end
	end
	
	// Execution Stage
	always @(posedge clk or posedge areset) begin
		if (areset || train_valid) begin
			branch_history <= 0;
		end else if (train_mispredicted) begin
			branch_history <= train_history;
		end
	end
	
	// Training Stage
	always @(posedge clk or posedge areset) begin
		if (areset || train_valid) begin
			pht[hash(train_pc, branch_history)] <= {2{train_taken}};
		end
	end
	
endmodule
