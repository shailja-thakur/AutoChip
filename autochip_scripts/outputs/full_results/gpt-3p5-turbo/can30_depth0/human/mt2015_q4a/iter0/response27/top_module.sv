module top_module(
	input x,
	input y,
	output z);
	
	// Declare internal wire
	wire w1;
	
	// Implement the boolean function z = (x^y) & x
	assign w1 = x ^ y;
	assign z = w1 & x;
	
endmodule
