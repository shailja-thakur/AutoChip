module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the logical AND of all bits in in[3:0] to out_and
    assign out_and = (in[0] & in[1] & in[2] & in[3]);

    // Assign the logical OR of all bits in in[3:0] to out_or
    assign out_or = (in[0] | in[1] | in[2] | in[3]);

    // Assign the logical XOR of all bits in in[3:0] to out_xor
    assign out_xor = (in[0] ^ in[1] ^ in[2] ^ in[3]);

endmodule
