module top_module (
    input [99:0] in,
    output wire [98:0] out_both,
    output wire [99:0] out_any,
    output wire [99:0] out_different
);

    assign out_both = in[98:0] & in[99:1];
    assign out_any = in | in;
    assign out_different = {in[0] ^ in[99], in[98:1]};

endmodule
