module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// out_both
	assign out_both[0] = in[0] & in[99];
	assign out_both[1:98] = in[1:98] & in[0:97];

	// out_any
	assign out_any[1:99] = in[0:98] | in[1:99];
	
	// out_different
	assign out_different[0] = in[99] != in[0];
	assign out_different[1:98] = in[1:98] != in[0:97];
	assign out_different[99] = in[98] != in[99];

endmodule
