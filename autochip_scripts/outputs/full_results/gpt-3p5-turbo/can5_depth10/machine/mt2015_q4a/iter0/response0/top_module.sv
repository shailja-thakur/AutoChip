module top_module(
	input x,
	input y,
	output z);

	// Intermediate wires
	wire x_xor_y;
	wire x_and_xor;

	// Logic gates
	xor(x_xor_y, x, y);
	and(x_and_xor, x_xor_y, x);

	// Output
	assign z = x_and_xor;

endmodule
