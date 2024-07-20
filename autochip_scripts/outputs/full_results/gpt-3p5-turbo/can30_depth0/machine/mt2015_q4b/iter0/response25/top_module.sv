module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to store output of XOR gate
	wire xor_out;

	// XOR gate to compute the exclusive-or of x and y
	xor_gate u1(
		.x(x),
		.y(y),
		.z(xor_out)
	);

	// Inverter to negate the output of XOR gate
	not_gate u2(
		.a(xor_out),
		.z(z)
	);

endmodule
module xor_gate(
	input x,
	input y,
	output z);

	// XOR gate logic
	assign z = x ^ y;

endmodule
module not_gate(
	input a,
	output z);

	// Inverter logic
	assign z = ~a;

endmodule
