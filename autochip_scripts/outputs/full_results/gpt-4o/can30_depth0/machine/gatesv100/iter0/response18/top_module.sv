module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate second input signal, which is the first input signal shifted by one bit to the right
    wire [99:0] in_shifted = {in[98:0], in[99]};

    // Perform bit-wise AND operation to generate out_both
    assign out_both = in[99:1] & in_shifted[99:1];

    // Perform bit-wise OR operation to generate out_any
    assign out_any = in | in_shifted;

    // Perform bit-wise XOR operation to generate out_different
    assign out_different = in ^ in_shifted;

endmodule
