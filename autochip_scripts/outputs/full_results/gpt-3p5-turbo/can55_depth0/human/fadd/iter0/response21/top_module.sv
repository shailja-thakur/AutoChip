module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign {cout, sum} = a + b + cin;

endmodule
module top_module(
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Instantiate the Full Adder module
	full_adder adder_instance(
		.a(a),
		.b(b),
		.cin(cin),
		.cout(cout),
		.sum(sum)
	);

endmodule
