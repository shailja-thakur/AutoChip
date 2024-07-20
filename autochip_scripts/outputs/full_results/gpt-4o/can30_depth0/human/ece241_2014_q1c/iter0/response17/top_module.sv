module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Add the two 8-bit numbers
    assign s = a + b;

    // Compute overflow
    // Overflow occurs if the sign bit of 'a' and 'b' are the same, but the sign bit of 's' is different
    assign overflow = ((a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]));

endmodule
