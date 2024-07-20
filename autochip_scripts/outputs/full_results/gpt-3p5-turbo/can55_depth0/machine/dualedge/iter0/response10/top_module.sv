module top_module(
	input clk,
	input d,
	output reg q);

	// Declare registers qp and qn
	reg qp;
	reg qn;
	
	always @(posedge clk) begin
		// Update register qp with value of d when clk is positive
		qp <= d;
	end
	
	always @(negedge clk) begin
		// Update register qn with value of d when clk is negative
		qn <= d;
	end
	
	always @(clk) begin
		// Assign value of qp to output q when clk is positive
		if (clk)
			q <= qp;
		// Assign value of qn to output q when clk is negative
		else
			q <= qn;
	end
	
endmodule
