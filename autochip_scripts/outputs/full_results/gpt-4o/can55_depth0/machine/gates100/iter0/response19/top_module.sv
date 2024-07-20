module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    assign out_and = &in;  // Logical AND of all bits in the input vector
    assign out_or = |in;   // Logical OR of all bits in the input vector
    assign out_xor = ^in;  // Logical XOR of all bits in the input vector

endmodule
