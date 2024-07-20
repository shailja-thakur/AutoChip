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
reg [6:0] pht_index;
reg [1:0] pht_value;
reg [6:0] training_history;
reg [6:0] training_pc;

reg [1:0] pht [0:127];

always @(posedge clk or posedge areset) begin
	if (areset)
		global_history <= 7'b0000000;
	else if (predict_valid) begin
		pht_index <= predict_pc ^ global_history;
		predict_taken <= pht[pht_index][1];
		predict_history <= global_history;
	end else if (train_valid) begin
		training_pc <= train_pc;
		training_history <= train_history;
		
		if (train_mispredicted) begin
			pht[train_pc ^ train_history][1] <= 2'b00;
			global_history <= train_history;
		end else
			pht[train_pc ^ train_history][1] <= train_taken;
	end
end

always @(posedge clk) begin
	if (train_valid) begin
		pht[training_pc ^ training_history][1] <= train_taken;
		global_history <= training_history;
	end
end

endmodule
