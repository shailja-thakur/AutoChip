module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire s, c;

	// Instantiate half_adder module
	half_adder HA (
		.a(a),
		.b(b),
		.s(s),
		.c(c)
	);

	// Output signals
	assign sum = s;
	assign cout = c;

endmodule
module half_adder (
	input a,
	input b,
	output s,
	output c
);

	// Logic for sum and carry-out
	xor(s, a, b);
	and(c, a, b);

endmodule
