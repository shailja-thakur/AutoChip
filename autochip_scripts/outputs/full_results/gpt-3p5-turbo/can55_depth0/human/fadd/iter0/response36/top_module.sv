module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal signals
wire s1, s2, s3;
wire c1, c2;

// Instantiate the first XOR gate
xor_gate x1 (
	.a(a),
	.b(b),
	.y(s1)
);

// Instantiate the second XOR gate
xor_gate x2 (
	.a(s1),
	.b(cin),
	.y(sum)
);

// Instantiate the first AND gate
and_gate a1 (
	.a(a),
	.b(b),
	.y(c1)
);

// Instantiate the second AND gate
and_gate a2 (
	.a(s1),
	.b(cin),
	.y(c2)
);

// Instantiate the OR gate
or_gate o1 (
	.a(c1),
	.b(c2),
	.y(cout)
);

endmodule
