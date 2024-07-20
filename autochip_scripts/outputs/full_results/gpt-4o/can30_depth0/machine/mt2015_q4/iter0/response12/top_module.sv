module top_module(
	input x,
	input y,
	output z);

	// Intermediate signals
	wire out1, out2;

	// First gate (AND gate)
	and u1 (out1, x, y); // x and y are inputs

	// Second gate (OR gate)
	or u2 (out2, y, x);  // y and x are inputs

	// Third gate (XOR gate)
	xor u3 (z, out1, out2); // out1 and out2 are inputs

endmodule
