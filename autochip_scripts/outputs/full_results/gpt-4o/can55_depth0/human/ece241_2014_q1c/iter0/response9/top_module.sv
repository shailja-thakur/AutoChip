module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Compute the sum
	assign s = a + b;

	// Compute overflow: overflow occurs if the signs of the operands are the same,
	// but the sign of the result is different.
	assign overflow = ((a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]));

endmodule
