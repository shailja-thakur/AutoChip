module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = &in; // AND reduction operation
    assign out_or = |in;  // OR reduction operation
    assign out_xor = ^in; // XOR reduction operation
endmodule
