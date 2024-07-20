module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // AND operation: All bits must be 1 for output to be 1
    assign out_and = &in;

    // OR operation: At least one bit must be 1 for output to be 1
    assign out_or = |in;

    // XOR operation: Odd number of bits must be 1 for output to be 1
    assign out_xor = ^in;

endmodule
