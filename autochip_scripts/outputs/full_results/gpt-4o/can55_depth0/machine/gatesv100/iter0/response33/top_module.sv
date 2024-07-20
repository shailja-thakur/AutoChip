module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;

    // Shift the input by one bit
    assign shifted_in = {in[98:0], 1'b0};

    // Output out_both
    assign out_both = in[99:1] & shifted_in[99:1];

    // Output out_any
    assign out_any = in | shifted_in;

    // Output out_different, specially handling the first bit separately
    assign out_different[0] = in[0] ^ shifted_in[99];
    assign out_different[99:1] = in[99:1] ^ shifted_in[99:1];

endmodule
