module top_module(
	input x,
	input y,
	output z);

	// Wire Declaration
	wire x_xor_y;
	wire x_and_x_xor_y;

	// XOR Gate
	xor(x_xor_y, x, y);

	// AND Gate
	and(x_and_x_xor_y, x, x_xor_y);

	// Output
	assign z = x_and_x_xor_y;

endmodule
