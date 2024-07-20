module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Output vector to indicate if both the current bit and its left neighbor are '1'
	assign out_both[98:0] = in[98:0] & in[99:1];

	// Output vector to indicate if any of the current bit and its right neighbor are '1'
	assign out_any[99:1] = in[99:1] | in[98:0];

	// Output vector to indicate if the current bit is different from its left neighbor
	assign out_different[98:0] = in[98:0] ^ in[99:1];
	assign out_different[99] = in[99] ^ in[0];

endmodule
