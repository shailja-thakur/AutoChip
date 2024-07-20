module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Create the shifted input signal
    wire [99:0] in_shifted;
    assign in_shifted = in << 1;

    // Generate out_both which is 99-bit wide
    assign out_both = in[99:1] & in_shifted[99:1];

    // Generate out_any which is 100-bit wide
    assign out_any = in | in_shifted;

    // Generate out_different which is 100-bit wide
    assign out_different = in ^ {in[98:0], in[99]};

endmodule
