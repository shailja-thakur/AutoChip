module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// wire declaration for intermediate signals
	wire carry_out;
	wire signed_overflow;

	// assign statement for sum output
	assign s = a + b;

	// assign statement for carry out
	assign carry_out = (a[7] & b[7]) | (s[7] & ~(a[7] | b[7]));

	// assign statement for signed overflow
	assign signed_overflow = (a[7] == b[7]) & (s[7] != a[7]);

	// assign statement for overflow output
	assign overflow = carry_out | signed_overflow;

endmodule
