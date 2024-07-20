module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] sel_index;

// Create a 256-to-1 multiplexer
wire [3:0] mux_out;
assign mux_out = in[sel * 4 +: 4];

// Decoder for the select input
decoder_256to1 decoder (
	.in(sel),
	.out(sel_index)
);

// Connect the output of the decoder to the output of the multiplexer
assign out = mux_out;

endmodule
module decoder_256to1 (
	input [7:0] in,
	output [3:0] out
);
	assign out = in;
endmodule
