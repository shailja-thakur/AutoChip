module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    assign out_and = &in;  // AND all the bits in the input vector
    assign out_or = |in;   // OR all the bits in the input vector
    assign out_xor = ^in;  // XOR all the bits in the input vector

endmodule
