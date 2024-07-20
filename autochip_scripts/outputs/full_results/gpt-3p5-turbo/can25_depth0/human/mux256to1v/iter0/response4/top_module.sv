module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] in_sel;

assign in_sel[0] = in[sel * 4 + 3:sel * 4];
assign in_sel[1] = in[sel * 4 + 7:sel * 4 + 4];
assign in_sel[2] = in[sel * 4 + 11:sel * 4 + 8];
assign in_sel[3] = in[sel * 4 + 15:sel * 4 + 12];

assign out = in_sel;

endmodule
