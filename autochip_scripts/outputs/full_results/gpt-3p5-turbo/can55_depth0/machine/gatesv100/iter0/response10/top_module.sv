module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

wire [99:0] in_shift;
wire [98:0] out_and;

assign in_shift = {in[98:0], in[99]};
assign out_both = in & in_shift;
assign out_any = in | in_shift;
assign out_and = in ^ in_shift;
assign out_different = {out_and[98:0], out_and[0]};

endmodule
