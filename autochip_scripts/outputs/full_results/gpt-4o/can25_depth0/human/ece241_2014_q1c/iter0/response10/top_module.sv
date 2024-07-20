module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    assign s = a + b;
    
    // Overflow occurs if the sign bit (MSB) of a is the same as the sign bit of b,
    // but the sign bit of s is different from the sign bit of a and b.
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
