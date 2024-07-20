module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // AND gate for all 100 inputs
    assign out_and = &in;

    // OR gate for all 100 inputs
    assign out_or = |in;

    // XOR gate for all 100 inputs
    assign out_xor = ^in;

endmodule
