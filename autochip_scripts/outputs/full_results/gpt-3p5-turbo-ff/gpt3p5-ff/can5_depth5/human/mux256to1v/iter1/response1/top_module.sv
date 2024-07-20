module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] in_sel;

assign in_sel[0] = sel[0] ? in[7:4] : in[3:0];
assign in_sel[1] = sel[1] ? in[11:8] : in[7:4];
assign in_sel[2] = sel[2] ? in[15:12] : in[11:8];
assign in_sel[3] = sel[3] ? in[19:16] : in[15:12];

assign out = in_sel[sel[3:0]];

endmodule
