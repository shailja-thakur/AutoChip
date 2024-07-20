module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;

    // Shifted input signal by one bit
    assign shifted_in = {in[98:0], in[99]};  // Shifting left

    // out_both: bit-wise AND between in[99:1] and in[98:0]
    assign out_both = in[99:1] & in[98:0];

    // out_any: bit-wise OR between in and shifted_in
    assign out_any = in | shifted_in;

    // out_different: bit-wise XOR between in and shifted_in
    // First bit out_different[0] to be XOR of in[0] and shifted_in[99]
    assign out_different[0] = in[0] ^ shifted_in[99];
    assign out_different[99:1] = in[99:1] ^ shifted_in[98:0];

endmodule
