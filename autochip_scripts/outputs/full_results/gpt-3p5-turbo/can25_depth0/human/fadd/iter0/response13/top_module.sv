module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

	// Internal Wire Declarations
	wire x1, x2, x3;
	wire s1, s2, s3;

	// Full Adder Instantiation
	full_adder FA1(
		.a(a),
		.b(b),
		.cin(cin),
		.sum(x1),
		.cout(s1)
	);

	full_adder FA2(
		.a(x1),
		.b(cin),
		.cin(s1),
		.sum(x2),
		.cout(s2)
	);

	full_adder FA3(
		.a(x2),
		.b(s1),
		.cin(s2),
		.sum(x3),
		.cout(s3)
	);

	// Output Assignments
	assign cout = s3;
	assign sum = x3;

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

	// Intermediate Wire Declarations
	wire x1, x2, x3;

	// XOR Gates
	xor xor1(
		.a(a),
		.b(b),
		.o(x1)
	);

	xor xor2(
		.a(cin),
		.b(x1),
		.o(sum)
	);

	// AND Gates
	and and1(
		.a(a),
		.b(b),
		.o(x2)
	);

	and and2(
		.a(cin),
		.b(x1),
		.o(x3)
	);

	// OR Gate
	or or1(
		.a(x2),
		.b(x3),
		.o(cout)
	);

endmodule
