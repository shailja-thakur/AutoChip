module top_module(
	input clk,
	input d,
	output reg q);

	reg q_flip1, q_flip2;
	always @(posedge clk) begin
		q_flip1 <= d;
		q_flip2 <= q_flip1;
	end
	
	always @(posedge clk) begin
		q <= q_flip2;
	end
endmodule
