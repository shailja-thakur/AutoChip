module top_module(
	input x,
	input y,
	output z);

	/* Implementing the logical operations */
	assign z = (x ^ y) & x;

endmodule
