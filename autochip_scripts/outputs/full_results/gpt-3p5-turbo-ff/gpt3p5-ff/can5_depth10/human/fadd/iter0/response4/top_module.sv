module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	full_adder FA (
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout)
	);

endmodule
