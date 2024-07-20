module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the logical AND of all the bits in in[3:0] to out_and
    assign out_and = &in;

    // Assign the logical OR of all the bits in in[3:0] to out_or
    assign out_or = |in;

    // Assign the logical XOR of all the bits in in[3:0] to out_xor
    assign out_xor = ^in;

endmodule
