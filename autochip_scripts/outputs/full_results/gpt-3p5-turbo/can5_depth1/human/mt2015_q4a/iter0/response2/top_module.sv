module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to store the result of xor operation
	wire x_xor_y;

	// Xor gate to compute x^y
	xor_gate xor_inst (
		.x1(x),
		.x2(y),
		.z(x_xor_y)
	);

	// And gate to compute (x^y) & x
	and_gate and_inst (
		.x1(x_xor_y),
		.x2(x),
		.z(z)
	);

endmodule
