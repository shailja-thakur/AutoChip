module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by one bit
    wire [99:0] shifted_in = {in[98:0], in[99]};

    // Compute the bit-wise AND of the input and shifted input
    assign out_both = in & shifted_in[99:1];

    // Compute the bit-wise OR of the input and shifted input
    assign out_any = in | shifted_in;

    // Compute the bit-wise XOR of the input and shifted input
    assign out_different = in ^ shifted_in;

endmodule
