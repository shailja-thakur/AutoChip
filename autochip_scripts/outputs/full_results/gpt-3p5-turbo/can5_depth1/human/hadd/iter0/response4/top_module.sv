module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire s;
	wire c;

	// Instantiate half adder
	half_adder HA1(
		.a(a),
		.b(b),
		.sum(s),
		.cout(c)
	);

	// Assign outputs
	assign sum = s;
	assign cout = c;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// Logic for sum
	assign sum = a ^ b;

	// Logic for carry-out
	assign cout = a & b;

endmodule
