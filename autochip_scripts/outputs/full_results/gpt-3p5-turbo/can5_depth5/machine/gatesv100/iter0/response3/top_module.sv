module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    wire [98:0] and_out;
    wire [99:0] or_out;
    wire [99:0] xor_out;

    // Shifting the input signal by 1 bit
    assign shifted_in = {in[98:0], in[99]};

    // Bit-wise AND operation
    assign out_both = in[98:0] & shifted_in[98:0];

    // Bit-wise OR operation
    assign out_any = in | shifted_in;

    // Bit-wise XOR operation
    assign xor_out = in ^ shifted_in;
    // Generating the first bit of out_different by XORing the first bit of the input with the last bit of the shifted input
    assign out_different[0] = in[99] ^ shifted_in[99];
    // Assigning the rest of the bits of out_different
    assign out_different[98:1] = xor_out[98:1];

endmodule
