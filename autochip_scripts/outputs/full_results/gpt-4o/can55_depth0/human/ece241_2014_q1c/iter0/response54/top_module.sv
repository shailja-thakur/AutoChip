module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    // Adding two 8-bit numbers
    assign s = a + b;
    
    // Compute overflow: occurs if the sign of a and b are the same,
    // but different from the sign of the sum.
    assign overflow = ((a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]));

endmodule
