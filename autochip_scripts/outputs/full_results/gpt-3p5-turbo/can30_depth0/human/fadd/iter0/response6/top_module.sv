module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal signals
wire s1, s2;

// First XOR gate
xor gate1 (
	.a(a),
	.b(b),
	.z(s1)
);

// Second XOR gate
xor gate2 (
	.a(s1),
	.b(cin),
	.z(sum)
);

// AND gate
and gate3 (
	.a(a),
	.b(b),
	.z(s2)
);

// Third AND gate
and gate4 (
	.a(s1),
	.b(cin),
	.z(s2)
);

// OR gate
or gate5 (
	.a(s2),
	.b(sum),
	.z(cout)
);

endmodule
