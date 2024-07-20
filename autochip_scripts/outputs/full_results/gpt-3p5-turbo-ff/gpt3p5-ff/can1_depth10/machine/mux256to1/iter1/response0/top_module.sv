module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	wire out;

	assign out = in[sel];

endmodule
