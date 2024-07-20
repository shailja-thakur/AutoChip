module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform the logical AND operation on the 4-bit input
    assign out_and = (in[0] & in[1] & in[2] & in[3]);

    // Perform the logical OR operation on the 4-bit input
    assign out_or = (in[0] | in[1] | in[2] | in[3]);

    // Perform the logical XOR operation on the 4-bit input
    assign out_xor = (in[0] ^ in[1] ^ in[2] ^ in[3]);

endmodule
