module top_module(
	input clk,
	input d,
	output reg q);

	reg qp;
	reg qn;

	always @(posedge clk)
		qp <= d;

	always @(negedge clk)
		qn <= d;

	always @(clk)
		if (clk)
			q <= qp;
		else
			q <= qn;

endmodule
