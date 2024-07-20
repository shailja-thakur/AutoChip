module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    // Perform 8-bit addition
    assign s = a + b;

    // Check for signed overflow: 
    // Overflow occurs when adding two positive numbers results in a negative number,
    // or when adding two negative numbers results in a positive number.
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
