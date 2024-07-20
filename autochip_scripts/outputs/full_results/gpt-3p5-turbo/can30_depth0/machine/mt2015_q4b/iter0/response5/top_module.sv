module top_module(
	input x,
	input y,
	output z);

	// Logic gate using exclusive-or (XOR) and negation (NOT)
	assign z = ~(x ^ y);

endmodule
