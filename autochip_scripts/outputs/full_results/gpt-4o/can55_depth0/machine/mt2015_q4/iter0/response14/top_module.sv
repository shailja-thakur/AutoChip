module top_module(
	input x,
	input y,
	output z);

	wire out1, out2;

	// Instantiate the first gate (AND gate)
	and u1(out1, x, y);

	// Instantiate the second gate (OR gate)
	or u2(out2, y, x);

	// Instantiate the third gate (XOR gate)
	xor u3(z, out1, out2);

endmodule
