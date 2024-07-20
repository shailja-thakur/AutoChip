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
reg [6:0] index;
reg [1:0] pht[0:127];

always @(posedge clk or posedge areset) begin
	if (areset)
		global_history <= 0;
	else if (train_valid)
		global_history <= train_history;
	else if (predict_valid)
		global_history <= {global_history[5:0], predict_taken};
end

always @(posedge clk) begin
	if (predict_valid) begin
		index <= predict_pc ^ global_history;
		predict_taken <= pht[index][1];
		predict_history <= global_history;
	end
end

always @(posedge clk) begin
	if (train_valid) begin
		index <= train_pc ^ train_history;
		if (train_mispredicted)
			pht[index] <= pht[index] - 2;
		else if (train_taken && (pht[index] < 3))
			pht[index] <= pht[index] + 1;
		else if (!train_taken && (pht[index] > 0))
			pht[index] <= pht[index] - 1;
			
		global_history <= {global_history[5:0], train_taken};
	end
end

endmodule
