module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    assign out_both = in[99:1] & in[98:0]; // Bit-wise AND, 99 bits
    assign out_any = in | {in[98:0], 1'b0}; // Bit-wise OR, 100 bits. Shifted input needs to be extended by 1 bit
    assign out_different[99] = in[99] ^ in[0]; // Special case for the first bit of out_different
    assign out_different[98:0] = in[98:0] ^ in[99:1]; // Bit-wise XOR, 99 bits starting from bit[98]

endmodule
