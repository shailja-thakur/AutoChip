module top_module(
	input clk,
	input d,
	output reg q);

	reg q_delayed;

	always @(posedge clk)
	  q_delayed <= q;

	always @(posedge clk)
	begin
	  if (d == 1'b1)
	    q <= ~q_delayed;
	end
endmodule
