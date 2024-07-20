module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire sum_int, cout_int;

	// Instantiate half_adder module
	half_adder HA (
		.a(a),
		.b(b),
		.sum(sum_int),
		.cout(cout_int)
	);

	// Assign outputs
	assign sum = sum_int;
	assign cout = cout_int;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// Define the truth table
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
