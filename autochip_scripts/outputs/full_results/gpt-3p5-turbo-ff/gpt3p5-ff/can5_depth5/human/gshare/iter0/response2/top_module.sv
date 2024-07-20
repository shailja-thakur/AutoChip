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
	reg predict_taken;
	reg [6:0] predict_history;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			global_history <= 0;
		else if (predict_valid) begin
			index <= (predict_pc ^ global_history) & 7'h7f;
			predict_taken <= (pht[index] == 2'b11) || (pht[index] == 2'b10);
			predict_history <= global_history;
		end else if (train_valid) begin
			index <= (train_pc ^ train_history) & 7'h7f;
			if (train_mispredicted) begin
				pht[index] <= (pht[index] == 2'b00) ? 2'b00 : (pht[index] == 2'b01) ? 2'b00 : (pht[index] == 2'b10) ? 2'b01 : 2'b11;
				global_history <= train_history;
			end else if (train_taken)
				pht[index] <= (pht[index] == 2'b00) ? 2'b01 : (pht[index] == 2'b01) ? 2'b11 : (pht[index] == 2'b10) ? 2'b11 : 2'b00;
		end
	end

endmodule
