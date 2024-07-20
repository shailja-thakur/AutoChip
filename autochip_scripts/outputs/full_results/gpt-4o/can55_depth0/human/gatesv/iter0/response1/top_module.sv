module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// out_both: Each bit should indicate whether both the corresponding input bit and its neighbour to the left are '1'
	assign out_both[0] = in[0] & in[1];
	assign out_both[1] = in[1] & in[2];
	assign out_both[2] = in[2] & in[3];

	// out_any: Each bit should indicate whether any of the corresponding input bit and its neighbour to the right are '1'
	assign out_any[1] = in[1] | in[0];
	assign out_any[2] = in[2] | in[1];
	assign out_any[3] = in[3] | in[2];

	// out_different: Each bit should indicate whether the corresponding input bit is different from its neighbour to the left; vector treated as wrapping around
	assign out_different[0] = in[0] ^ in[3]; // wrap around, in[3] is the neighbor to the left of in[0]
	assign out_different[1] = in[1] ^ in[0];
	assign out_different[2] = in[2] ^ in[1];
	assign out_different[3] = in[3] ^ in[2];

endmodule
