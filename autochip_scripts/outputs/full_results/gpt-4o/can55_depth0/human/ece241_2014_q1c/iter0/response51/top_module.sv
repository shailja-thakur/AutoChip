module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// 8-bit adder
	assign s = a + b;

	// Overflow detection logic for 2's complement addition
	// Overflow occurs if the sign of the result is different from the signs of both operands when they are the same.
	assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
