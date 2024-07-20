module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;

    // Shift the input vector by one bit
    assign shifted_in = {in[98:0], in[99]};

    // out_both is a bit-wise AND of in and shifted_in (99 bits wide)
    assign out_both = in[99:1] & shifted_in[98:0];

    // out_any is a bit-wise OR of in and shifted_in (100 bits wide)
    assign out_any = in | shifted_in;

    // out_different is a bit-wise XOR of in and shifted_in (100 bits wide)
    assign out_different = in ^ shifted_in;

endmodule
