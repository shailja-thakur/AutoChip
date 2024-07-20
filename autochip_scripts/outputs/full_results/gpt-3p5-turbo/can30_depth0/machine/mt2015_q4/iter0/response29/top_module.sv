module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire a_1, a_2, b_1, b_2;

	// Instantiate gates
	and_gate gate_1 (
		.a(x),
		.b(y),
		.z(a_1)
	);

	and_gate gate_2 (
		.a(y),
		.b(x),
		.z(b_1)
	);

	and_gate gate_3 (
		.a(a_1),
		.b(b_1),
		.z(z)
	);

endmodule
