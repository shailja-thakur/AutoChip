module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate out_both
    assign out_both = in & in[99:1];

    // Generate out_any
    assign out_any = in;

    // Generate out_different
    assign out_different = in ^ {in[0], in[99:1]};

endmodule
