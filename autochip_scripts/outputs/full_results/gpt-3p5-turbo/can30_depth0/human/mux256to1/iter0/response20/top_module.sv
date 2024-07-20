module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] mux_out;
assign out = mux_out[sel];

MUX_256_1 u1 (
	.in(in),
	.sel(sel),
	.out(mux_out)
);

module MUX_256_1 (
	input [255:0] in,
	input [7:0] sel,
	output out
);

assign out = in[sel];

endmodule
