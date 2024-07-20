module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Create intermediate wires for the logic
	wire w1, w2, w3;

	// First half adder
	xor_gate xor1 (
		.a(a),
		.b(b),
		.z(w1)
	);

	and_gate and1 (
		.a(a),
		.b(b),
		.z(w2)
	);

	// Second half adder
	xor_gate xor2 (
		.a(w1),
		.b(cin),
		.z(sum)
	);

	and_gate and2 (
		.a(w1),
		.b(cin),
		.z(w3)
	);

	// Final OR gate
	or_gate or1 (
		.a(w2),
		.b(w3),
		.z(cout)
	);

endmodule
