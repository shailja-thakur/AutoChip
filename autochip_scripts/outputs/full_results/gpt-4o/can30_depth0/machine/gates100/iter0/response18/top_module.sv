module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // AND operation across all bits
    assign out_and = &in;

    // OR operation across all bits
    assign out_or = |in;

    // XOR operation across all bits
    assign out_xor = ^in;

endmodule
