module top_module (
    input [2:0] in,
    output [1:0] out
);

    assign out[1] = in[2] ^ (in[1] & in[0]);    // Bitwise XOR of input bit 2 with bitwise AND of input bits 1 and 0
    assign out[0] = in[1] | (in[2] & in[0]);    // Bitwise OR of input bit 1 with bitwise AND of input bits 2 and 0

endmodule
