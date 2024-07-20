module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input signal by one bit
    wire [99:0] in_shifted = {in[98:0], in[99]};

    // Perform bit-wise AND operation to get out_both
    assign out_both = in & in_shifted[99:1];

    // Perform bit-wise OR operation to get out_any
    assign out_any = in | in_shifted;

    // Perform bit-wise XOR operation to get out_different
    assign out_different[99:1] = in ^ in_shifted[99:1];
    assign out_different[0] = in[0] ^ in_shifted[99];

endmodule
