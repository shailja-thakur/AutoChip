module top_module(
	input x,
	input y,
	output z);

	// compute the logical negation of the exclusive-or (XOR) of the two inputs
	assign z = ~(x ^ y);

endmodule
