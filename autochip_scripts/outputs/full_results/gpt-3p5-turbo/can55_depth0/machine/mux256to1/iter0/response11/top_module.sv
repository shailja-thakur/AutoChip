module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

wire [7:0] sel_index;
wire out_bit;

assign sel_index = sel;
assign out_bit = in[sel_index];

assign out = out_bit;

endmodule
