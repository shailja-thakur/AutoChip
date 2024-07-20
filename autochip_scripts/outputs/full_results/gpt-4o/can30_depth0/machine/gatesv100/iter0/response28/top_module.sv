module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Perform bit-wise AND for out_both
    assign out_both = in[99:1] & in_shifted[99:1];

    // Perform bit-wise OR for out_any
    assign out_any = in | in_shifted;

    // Perform bit-wise XOR for out_different
    assign out_different[99] = in[99] ^ in_shifted[0];                      // The first bit of out_different
    assign out_different[98:0] = in[98:0] ^ in_shifted[98:0];  // Remaining bits of out_different

endmodule
