module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_select;

assign in_select[0] = in[3:0];
assign in_select[1] = in[7:4];
assign in_select[2] = in[11:8];
assign in_select[3] = in[15:12];
// Similarly for the rest of the in_select assignments

assign out = in_select[sel];

endmodule
