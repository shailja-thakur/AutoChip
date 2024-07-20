module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Output: Each bit should indicate whether both the corresponding input bit and its neighbour to the left are '1'.
	assign out_both[98:0] = in[98:0] & in[99:1];

	// Output: Each bit should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
	assign out_any[99:2] = in[98:0] | in[99:1];

	// Output: Each bit should indicate whether the corresponding input bit is different from its neighbour to the left.
	assign out_different[99:0] = in[99] ^ in[98:0];

endmodule
