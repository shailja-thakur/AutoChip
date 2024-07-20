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

// Define constants
localparam WIDTH = 2;
localparam PHT_SIZE = 128;
localparam HISTORY_BITS = 7;

// Declare signals and registers
reg [HISTORY_BITS - 1:0] global_history;
reg [PHT_SIZE - 1:0] pattern_history_table;
reg [HISTORY_BITS - 1:0] train_predict_history;
reg [HISTORY_BITS - 1:0] branch_history;

// Update the branch history register
always @(posedge clk or posedge areset) begin
	if (areset)
		branch_history <= 0;
	else if (train_valid)
		branch_history <= train_history;
	else if (predict_valid)
		branch_history <= global_history;
end

// Update the global history register and predict branch direction
always @(posedge clk or posedge areset) begin
	if (areset)
		global_history <= 0;
	else begin
		global_history <= {global_history[HISTORY_BITS - 2:0], predict_taken};
		predict_taken <= pattern_history_table[predict_pc ^ global_history];
		predict_history <= global_history;
	end
end

// Update the pattern history table
always @(posedge clk or posedge areset) begin
	if (areset)
		pattern_history_table <= 0;
	else if (train_valid) begin
		if (train_mispredicted)
			pattern_history_table[train_pc ^ train_history] <= train_taken;
		train_predict_history <= train_history;
	end
end

endmodule
