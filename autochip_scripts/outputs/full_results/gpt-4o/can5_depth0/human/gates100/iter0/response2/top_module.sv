module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // AND Gate
    assign out_and = &in;

    // OR Gate
    assign out_or = |in;

    // XOR Gate
    assign out_xor = ^in;

endmodule
