module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire declaration
	wire [98:0] both;
	wire [99:1] any;
	wire [99:0] different;

	// Gate-level implementation for out_both
	assign both[98:0] = in[98:0] & in[99:1];
	
	// Gate-level implementation for out_any
	assign any[99:1] = |in[99:1];

	// Gate-level implementation for out_different
	assign different[98:0] = in[98:0] ^ in[99:0];
	assign different[99] = in[99] ^ in[0];

	// Output assignments
	assign out_both = both;
	assign out_any = any;
	assign out_different = different;

endmodule
