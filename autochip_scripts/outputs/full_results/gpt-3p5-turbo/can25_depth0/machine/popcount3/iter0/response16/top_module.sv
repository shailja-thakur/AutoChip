module top_module (
    input [2:0] in,
    output [1:0] out
);
    assign out[0] = in[0] ^ in[1] ^ in[2]; // XOR of the three input bits, stored in out[0]
    assign out[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]); // OR of the two possible pairs of input bits, stored in out[1]
endmodule
