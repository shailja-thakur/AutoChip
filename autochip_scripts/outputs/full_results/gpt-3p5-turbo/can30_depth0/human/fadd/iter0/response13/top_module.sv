module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wires
	wire internal_carry;
	wire internal_sum;

	// Instantiate full adder
	full_adder full_adder_inst (
		.a(a),
		.b(b),
		.cin(cin),
		.cout(internal_carry),
		.sum(internal_sum)
	);

	// Assign internal signals to external outputs
	assign cout = internal_carry;
	assign sum = internal_sum;
endmodule
