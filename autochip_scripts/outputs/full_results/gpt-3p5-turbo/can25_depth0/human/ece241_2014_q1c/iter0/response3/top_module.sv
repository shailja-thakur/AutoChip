module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire declarations
	wire carry;
	wire signed_add_overflow;

	// Logic to compute sum
	assign {carry, s} = a + b;

	// Logic to compute overflow
	assign overflow = signed_add_overflow;

	// Logic to detect signed addition overflow
	assign signed_add_overflow = (a[7] && b[7] && !s[7]) || (!a[7] && !b[7] && s[7]);

endmodule
