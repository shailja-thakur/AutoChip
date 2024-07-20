module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_sel;

assign in_sel[0] = in[3:0];
assign in_sel[1] = in[7:4];
assign in_sel[2] = in[11:8];
// complete the assignments for in_sel[3] to in_sel[255] based on the given logic

assign out = in_sel[sel];

endmodule
