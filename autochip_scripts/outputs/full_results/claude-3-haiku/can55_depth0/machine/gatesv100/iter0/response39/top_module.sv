module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Bit-wise AND operation to get out_both
    assign out_both = in[99:1] & in[98:0];

    // Bit-wise OR operation to get out_any
    assign out_any = in[99:1] | in[98:0];

    // Bit-wise XOR operation to get out_different
    // First bit is calculated separately
    assign out_different[0] = in[0] ^ in[99];
    assign out_different[99:1] = in[99:1] ^ in[98:0];

endmodule
