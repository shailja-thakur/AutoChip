module top_module(
	input wire clk,
	input wire d,
	output reg q);

	reg qp;
	reg qn;

	always @(posedge clk)
		qp <= d;

	always @(negedge clk)
		qn <= d;

	always @(posedge clk or negedge clk)
		if (clk)
			q <= qp;
		else
			q <= qn;

endmodule
