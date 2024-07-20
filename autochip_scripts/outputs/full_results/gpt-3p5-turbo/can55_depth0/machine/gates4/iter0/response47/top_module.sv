module top (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    assign out_and = in[3] & in[2] & in[1] & in[0]; // logical AND operation on all input bits
    assign out_or = in[3] | in[2] | in[1] | in[0]; // logical OR operation on all input bits
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0]; // logical XOR operation on all input bits

endmodule
