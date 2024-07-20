module top_module(
	input x,
	input y,
	output z);

	// Intermediate signals
	wire w1, w2;

	// XOR gate
	xor_gate(x, y, w1);

	// AND gate
	and_gate(w1, x, w2);

	// Output
	assign z = w2;

	// XOR gate definition
	gate xor_gate(
		input a,
		input b,
		output y
	);
	xor xor_gate_inst(
		.a(a),
		.b(b),
		.y(y)
	);

	// AND gate definition
	gate and_gate(
		input a,
		input b,
		output y
	);
	and and_gate_inst(
		.a(a),
		.b(b),
		.y(y)
	);

endmodule
