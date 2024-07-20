module top_module(
	input x,
	input y,
	output z);

	// assign the output z using logical AND operation
	assign z = (x ^ y) & x;

endmodule
