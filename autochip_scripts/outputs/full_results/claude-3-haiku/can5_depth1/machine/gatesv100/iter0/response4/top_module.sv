module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Create a shifted version of the input signal
    wire [99:0] in_shifted = {in[98:0], in[99]};

    // Compute the bit-wise AND of the input and shifted signals
    assign out_both = in & in_shifted[99:1];

    // Compute the bit-wise OR of the input and shifted signals
    assign out_any = in | in_shifted;

    // Compute the bit-wise XOR of the input and shifted signals
    assign out_different = in ^ in_shifted;

endmodule
