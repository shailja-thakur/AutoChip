module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire s, c;

	// Instantiate the half adder module
	half_adder HA(
		.a(a),
		.b(b),
		.sum(s),
		.cout(c)
	);

	// Assign internal signals to module outputs
	assign sum = s;
	assign cout = c;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output carry_out
);
	
	// Calculate the sum and carry-out
	assign sum = a ^ b;
	assign carry_out = a & b;

endmodule
