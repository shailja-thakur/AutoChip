module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    // Perform the addition
    assign s = a + b;
    
    // Compute the overflow
    // Overflow occurs if the sign bit of a and b are the same,
    // but the sign bit of s is different from a and b.
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
