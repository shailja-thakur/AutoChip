module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] mux_out;

assign out = mux_out;

// Instantiate the 256-to-1 multiplexer
mux256to1 mux (
	.in0(in[sel*256 +: 4]),
	.in1(in[sel*256 + 4 +: 4]),
	.in2(in[sel*256 + 8 +: 4]),
	.in3(in[sel*256 + 12 +: 4]),
	...
	.out(mux_out)
);

endmodule
