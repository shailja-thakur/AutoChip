module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;  // Positive edge register
	reg qn;  // Negative edge register

	always @(posedge clk)
		qp <= d;
	
	always @(negedge clk)
		qn <= d;

	assign q = (clk == 1'b0) ? qn : qp;  // Assign synchronized output

endmodule
