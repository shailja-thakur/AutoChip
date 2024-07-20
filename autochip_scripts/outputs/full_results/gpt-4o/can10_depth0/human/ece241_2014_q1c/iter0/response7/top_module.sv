module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	assign s = a + b; // Perform 8-bit addition
	
	// Compute signed overflow
	// Overflow occurs if the sign bit of a and b are the same but different from the sign bit of the result
	assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
