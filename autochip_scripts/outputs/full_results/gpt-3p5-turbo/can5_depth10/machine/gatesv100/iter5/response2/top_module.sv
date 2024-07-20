module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    assign out_both = in[98:0] & in[99:1];  // Corrected indexing for out_both assignment

    assign out_any = in | in[99];  // Bit-wise OR operation to generate out_any

    assign out_different[0] = in[0] ^ in[99];  // XOR operation between the first bit of in and the last bit of in[99] for out_different[0]
    assign out_different[99:1] = in[98:0] ^ in[99:1];  // XOR operation between corresponding bits of in and in[99:1] for out_different[99:1]

endmodule
