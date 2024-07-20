module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Sum of a and b
	assign s = a + b;

	// Overflow occurs when the sign of the sum is different from the signs of the inputs
	// Specifically, when both inputs have the same sign, but the result has a different sign.
	assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
