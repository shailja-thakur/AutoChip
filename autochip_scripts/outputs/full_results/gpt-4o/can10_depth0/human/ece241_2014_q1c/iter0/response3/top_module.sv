module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    assign s = a + b;

    // Overflow detection logic
    // Overflow occurs if the two MSBs of a and b are the same, but the MSB of the sum is different from them
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
