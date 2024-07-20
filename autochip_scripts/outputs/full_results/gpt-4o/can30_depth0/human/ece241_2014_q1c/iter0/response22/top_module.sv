module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    assign s = a + b;

    // To detect overflow:
    // Overflow occurs if the sign of the sum is different from the signs of both operands
    // when both operands have the same sign.
    // XOR of signs of a and b should be 0 if they have same sign
    // XOR of signs of sum and a (or b) should be 1 if overflow occurs
    assign overflow = (~(a[7] ^ b[7]) & (a[7] ^ s[7]));

endmodule
