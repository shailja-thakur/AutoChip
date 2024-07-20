module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// signal declaration
	wire [98:0] both;
	wire [99:0] any, different;

	// logic for out_both signal
	assign both = in[98:0] & in[99:1];
	assign out_both = both;

	// logic for out_any signal
	assign any = in | (in << 1);
	assign out_any = any;

	// logic for out_different signal
	assign different = in ^ (in << 1);
	assign out_different[0] = in[0] ^ in[99];
	assign out_different[1:99] = different;

endmodule
