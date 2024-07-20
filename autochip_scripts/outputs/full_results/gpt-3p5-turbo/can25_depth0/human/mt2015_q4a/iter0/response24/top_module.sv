module top_module(
	input x,
	input y,
	output z);

	// define intermediate variables
	wire w1;
	wire w2;
	
	// implement the logical operations
	assign w1 = x ^ y;
	assign w2 = w1 & x;
	assign z = w2;
	
endmodule
