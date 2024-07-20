module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire declaration for intermediate signals
	wire carry;

	// Adder
	assign s = a + b;
	assign carry = (a[7] & b[7]) | (a[7] & ~s[7]) | (b[7] & ~s[7]);

	// Overflow detection
	assign overflow = carry ^ (s[7] & ~a[7] & ~b[7]);

endmodule
