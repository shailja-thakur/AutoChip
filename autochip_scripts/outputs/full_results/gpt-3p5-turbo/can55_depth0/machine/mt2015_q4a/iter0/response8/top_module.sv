module top_module(
	input x,
	input y,
	output z);

	// Internal wires
	wire xor1_out;
	wire and1_out;

	// XOR gate
	xor xor1(
		.x(x),
		.y(y),
		.out(xor1_out)
	);

	// AND gate
	and and1(
		.x(xor1_out),
		.y(x),
		.out(and1_out)
	);

	// Output assignment
	assign z = and1_out;

endmodule
