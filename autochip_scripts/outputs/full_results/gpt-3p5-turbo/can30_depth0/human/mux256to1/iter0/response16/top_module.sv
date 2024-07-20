module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] mux_output;
assign mux_output = in[sel];

assign out = mux_output[0];

endmodule
