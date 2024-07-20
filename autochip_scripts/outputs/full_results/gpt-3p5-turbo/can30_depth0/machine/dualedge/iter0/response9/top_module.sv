module top_module(
	input clk,
	input d,
	output reg q);

	// Declare registers qp and qn
	reg qp, qn;

	// Always block to update qp and qn based on clk
	always @(posedge clk)
		qp <= d;
	always @(negedge clk)
		qn <= d;

	// Assign q based on value of clk
	always @(posedge clk or negedge clk)
		if (clk)
			q <= qp;
		else
			q <= qn;
			 
endmodule
