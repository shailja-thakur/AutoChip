module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] sel_addr;
assign sel_addr = sel * 4;

assign out = in[sel_addr +: 4];

endmodule
