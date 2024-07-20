module top_module (
    input [255:0] in,
    input [7:0] sel,
    output wire out
);

wire [7:0] sel_bit;

assign sel_bit = sel < 256'b1;

assign out = in[sel_bit];

endmodule
