module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the result of the logical AND operation on all bits of in[3:0] to out_and
    assign out_and = &in;

    // Assign the result of the logical OR operation on all bits of in[3:0] to out_or
    assign out_or = |in;

    // Assign the result of the logical XOR operation on all bits of in[3:0] to out_xor
    assign out_xor = ^in;

endmodule
