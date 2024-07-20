module top_module (
    input [2:0] in,
    output [1:0] out
);

    assign out[1] = in[2] | in[1];    // Bitwise OR of input bits 2 and 1
    assign out[0] = in[0] ^ in[1];    // Bitwise XOR of input bits 0 and 1

endmodule
