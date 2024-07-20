module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire carry_in, carry_out;
    assign carry_in = 0;

    assign {carry_out, s} = a + b;

    // Overflow occurs when the sign bits of the inputs are the same, but differ from the sign bit of the sum
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));
endmodule
