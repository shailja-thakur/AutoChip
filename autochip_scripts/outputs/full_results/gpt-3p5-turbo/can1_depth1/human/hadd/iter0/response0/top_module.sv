module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire carry;

	// Declare the half adder module
	half_adder HA (
		.a(a),
		.b(b),
		.sum(sum),
		.carry(carry)
	);

	// Assign the carry-out signal
	assign cout = carry;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output carry
);

	// Assign the sum and carry-out signals
	assign sum = a ^ b;
	assign carry = a & b;

endmodule
