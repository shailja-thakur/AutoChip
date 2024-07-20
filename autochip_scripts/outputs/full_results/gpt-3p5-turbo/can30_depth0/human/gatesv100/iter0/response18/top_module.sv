module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// (1) out_both
	assign out_both[98] = in[98] & in[99];
	assign out_both[97:0] = in[97:0] & in[98:1];

	// (2) out_any
	assign out_any[99:1] = in[98:0] | in[99:1];

	// (3) out_different
	assign out_different[98] = in[98] ^ in[99];
	assign out_different[97:0] = in[97:0] ^ in[98:0];

endmodule
