module top_module(
	input x,
	input y,
	output z);

	// Declare internal wires
	wire x_xor_y;
	wire x_and_xor;

	// Implement XOR gate
	xor_gate xor_inst(
		.A(x),
		.B(y),
		.Z(x_xor_y)
	);

	// Implement AND gate
	and_gate and_inst(
		.A(x_xor_y),
		.B(x),
		.Z(z)
	);

endmodule
module xor_gate(
	input A,
	input B,
	output Z
);
	xor u1 (
		.A(A),
		.B(B),
		.Z(Z)
	);
endmodule
module and_gate(
	input A,
	input B,
	output Z
);
	and u1 (
		.A(A),
		.B(B),
		.Z(Z)
	);
endmodule
