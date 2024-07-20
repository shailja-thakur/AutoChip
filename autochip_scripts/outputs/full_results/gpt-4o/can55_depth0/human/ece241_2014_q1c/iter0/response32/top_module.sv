module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    // Adding the two 8-bit 2's complement numbers
    assign s = a + b;

    // Checking for signed overflow
    // Overflow occurs if the sign bit of a and b are the same,
    // but the sign bit of the sum is different from the sign bit of a and b.
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
