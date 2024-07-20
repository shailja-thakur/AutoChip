module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Declare internal wires
	wire temp;

	// Instantiate the XOR gate
	xor_gate xor(
		.a(a),
		.b(b),
		.z(sum)
	);

	// Instantiate the AND gate
	and_gate and(
		.a(a),
		.b(b),
		.z(temp)
	);

	// Output the carry-out
	assign cout = temp;

endmodule
module xor_gate (
	input a,
	input b,
	output z
);
	assign z = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
