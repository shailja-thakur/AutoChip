module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	assign s = a + b;

	// Overflow detection for 2's complement addition
	// Overflow occurs if the sign of the inputs are the same, but the sign of the output is different
	assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
