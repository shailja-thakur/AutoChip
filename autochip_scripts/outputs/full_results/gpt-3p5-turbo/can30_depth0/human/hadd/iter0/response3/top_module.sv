module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Create a half adder
	// Instantiate the XOR gate
	xor_gate xor1(
		.a(a),
		.b(b),
		.y(sum)
	);

	// Instantiate the AND gate
	and_gate and1(
		.a(a),
		.b(b),
		.y(cout)
	);

endmodule
module xor_gate (
	input a,
	input b,
	output y
);

	assign y = a ^ b;

endmodule
module and_gate (
	input a,
	input b,
	output y
);

	assign y = a & b;

endmodule
