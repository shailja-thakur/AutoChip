module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = &in;       // AND of all bits in the input vector
    assign out_or = |in;        // OR of all bits in the input vector
    assign out_xor = ^in;       // XOR of all bits in the input vector
endmodule
