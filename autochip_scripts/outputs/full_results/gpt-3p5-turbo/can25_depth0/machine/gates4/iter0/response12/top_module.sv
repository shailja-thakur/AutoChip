module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign out_and to the result of logical AND operation on all input bits
    assign out_and = in[0] & in[1] & in[2] & in[3];

    // Assign out_or to the result of logical OR operation on all input bits
    assign out_or = in[0] | in[1] | in[2] | in[3];

    // Assign out_xor to the result of logical XOR operation on all input bits
    assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule
