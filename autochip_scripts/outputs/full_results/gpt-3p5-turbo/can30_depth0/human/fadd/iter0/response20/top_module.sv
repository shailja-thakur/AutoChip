module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires
	wire s1, s2, c1, c2;

	// Instantiate full adder modules
	full_adder fa1(
		.a(a),
		.b(b),
		.cin(cin),
		.sum(s1),
		.cout(c1)
	);

	full_adder fa2(
		.a(s1),
		.b(cin),
		.cin(c1),
		.sum(sum),
		.cout(c2)
	);

	// Output assignments
	assign cout = c2;

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	
	// Internal wires
	wire w1, w2, w3;

	// XOR gates
	xor_gate xor1(
		.a(a),
		.b(b),
		.y(w1)
	);

	xor_gate xor2(
		.a(w1),
		.b(cin),
		.y(sum)
	);

	// AND gates
	and_gate and1(
		.a(a),
		.b(b),
		.y(w2)
	);

	and_gate and2(
		.a(a),
		.b(cin),
		.y(w3)
	);

	and_gate and3(
		.a(b),
		.b(cin),
		.y(cout)
	);

	// OR gate
	or_gate or1(
		.a(w2),
		.b(w3),
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
module or_gate (
	input a,
	input b,
	output y
);
	
	assign y = a | b;

endmodule
