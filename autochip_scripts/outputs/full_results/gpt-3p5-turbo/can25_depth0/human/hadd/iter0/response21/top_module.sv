module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire sum_int;
	wire cout_int;

	// Instantiate a half adder module
	half_adder ha_inst (
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
	output carry_out
);

	// XOR gate for sum
	assign sum = a ^ b;

	// AND gate for carry out
	assign carry_out = a & b;

endmodule
