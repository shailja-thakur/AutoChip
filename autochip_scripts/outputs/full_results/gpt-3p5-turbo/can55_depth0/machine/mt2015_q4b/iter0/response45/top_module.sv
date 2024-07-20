module top_module(
	input x,
	input y,
	output z);

	// Negating the XOR of the inputs
	assign z = ~(x ^ y);

endmodule
