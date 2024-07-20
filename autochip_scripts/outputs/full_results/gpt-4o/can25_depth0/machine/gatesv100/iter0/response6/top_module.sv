module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input by one bit to the right
    wire [99:0] in_shifted;
    assign in_shifted = {1'b0, in[99:1]};

    // Generate out_both, out_any, and out_different signals
    assign out_both = in[98:0] & in_shifted[98:0];
    assign out_any = in | in_shifted;
    assign out_different = in ^ {in[0], in[99:1]};

endmodule
