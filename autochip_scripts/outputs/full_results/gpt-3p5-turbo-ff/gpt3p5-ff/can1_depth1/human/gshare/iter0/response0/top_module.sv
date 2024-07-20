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

reg [6:0] global_history;
reg [6:0] predict_index;
reg [1:0] predict_state;
reg [6:0] train_index;
reg [1:0] train_state;
reg [1:0] predict_outcome;

reg predict_taken;
reg [6:0] predict_history;

reg [1:0] pht [0:127];

always @(posedge clk or posedge areset) begin
	if (areset)
		global_history <= 0;
	else if (predict_valid) begin
		predict_index <= predict_pc ^ global_history;
		predict_state <= pht[predict_index];
		predict_taken <= (predict_state[1] == 2) || (predict_state[1] == 3);
		predict_history <= global_history;
	end else begin
		predict_taken <= 0;
		predict_history <= 0;
	end

	if (train_valid) begin
		train_index <= train_pc ^ train_history;
		train_state <= pht[train_index];
		predict_outcome <= (train_taken == 1) ? {(predict_state[0] == 2), (predict_state[0] == 3)} : {(predict_state[0] == 1), (predict_state[0] == 2)};
		if (train_mispredicted) begin
			global_history <= train_history;
			pht[train_index] <= predict_outcome;
		end else begin
			pht[train_index] <= (predict_outcome[0] == 1) ? (train_state + 1) : (train_state - 1);
		end
	end
end

endmodule
