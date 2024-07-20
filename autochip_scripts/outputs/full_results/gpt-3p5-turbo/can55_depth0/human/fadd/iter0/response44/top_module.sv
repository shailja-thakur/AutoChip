module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wires
	wire w1, w2, w3;

	// Instantiate the full adder
	full_adder FA1 (
		.a(a),
		.b(b),
		.cin(cin),
		.cout(w1),
		.sum(w2)
	);

	// Instantiate another full adder using the carry-out from the first full adder
	full_adder FA2 (
		.a(w2),
		.b(w3),
		.cin(w1),
		.cout(cout),
		.sum(sum)
	);
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// XOR gate for calculating sum
	xor gate1 (
		.a(a),
		.b(b),
		.z(sum)
	);

	// XOR gate for calculating carry-out
	xor gate2 (
		.a(a),
		.b(b),
		.z(w1)
	);

	// AND gate for calculating carry-out
	and gate3 (
		.a(a),
		.b(b),
		.z(w2)
	);

	// OR gate for calculating carry-out
	or gate4 (
		.a(gate2),
		.b(cin),
		.z(cout)
	);

endmodule
