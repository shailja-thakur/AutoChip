module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;

    assign in_shifted = in << 1;
    assign out_both = in[98:0] & in_shifted[99:1];
    assign out_any = in | in_shifted;
    assign out_different = in ^ {in_shifted[99], in[99:1]};

endmodule
