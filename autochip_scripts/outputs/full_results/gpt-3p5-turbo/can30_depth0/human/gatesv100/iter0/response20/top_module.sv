module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

wire [98:0] in_left_shifted;
wire [99:1] in_right_shifted;

assign in_left_shifted[0] = in[99];
assign in_left_shifted[1:98] = in[98:1];

assign in_right_shifted[0:98] = in[1:99];

assign out_both = &({in[98:0], in[99]});
assign out_any = |({in[0], in_right_shifted[0:98]});
assign out_different = in ^ in_left_shifted;

endmodule
