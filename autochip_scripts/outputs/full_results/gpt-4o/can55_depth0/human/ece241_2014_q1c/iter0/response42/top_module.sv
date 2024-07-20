module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// Perform the addition
	assign s = a + b;
	
	// Calculate the overflow
	// Overflow occurs if the sign of the sum is different from the signs of both operands
	// Overflow if the sign bit of a and b are the same, and the sign bit of s is different
	assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
