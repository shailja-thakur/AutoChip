module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [7:0] sel_upper;
wire [3:0] in_sel;

assign sel_upper = sel << 2;
assign in_sel = in[sel_upper +: 4];

assign out = in_sel;

endmodule
