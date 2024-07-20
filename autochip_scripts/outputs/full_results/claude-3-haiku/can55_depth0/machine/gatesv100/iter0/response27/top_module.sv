module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Assign the shifted input signal
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], in[99]};

    // Bit-wise AND operation to generate out_both
    assign out_both = in & in_shifted[99:1];

    // Bit-wise OR operation to generate out_any
    assign out_any = in | in_shifted;

    // Bit-wise XOR operation to generate out_different
    assign out_different[99:1] = in ^ in_shifted[99:1];
    assign out_different[0] = in[0] ^ in_shifted[99];

endmodule
