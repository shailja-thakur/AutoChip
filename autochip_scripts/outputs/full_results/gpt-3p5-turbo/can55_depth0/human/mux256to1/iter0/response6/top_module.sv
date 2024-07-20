module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	assign out = sel >= 256 ? 0 : in[sel];
endmodule
