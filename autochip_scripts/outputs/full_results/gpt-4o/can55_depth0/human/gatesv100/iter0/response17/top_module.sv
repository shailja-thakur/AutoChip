module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left are '1'.
	// Example: out_both[98] should indicate if in[98] and in[99] are both 1. Note that out_both[99] is not needed.
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin: gen_out_both
			assign out_both[i] = in[i] & in[i+1];
		end
	endgenerate

	// out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
	// Example: out_any[2] should indicate if either in[2] or in[1] are 1. Note that out_any[0] is not needed.
	generate
		for (i = 1; i < 100; i = i + 1) begin: gen_out_any
			assign out_any[i] = in[i] | in[i-1];
		end
	endgenerate

	// out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left.
	// Example: out_different[98] should indicate if in[98] is different from in[99]. For this part, treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0].
	assign out_different[99] = in[99] ^ in[0];
	generate
		for (i = 0; i < 99; i = i + 1) begin: gen_out_different
			assign out_different[i] = in[i] ^ in[i+1];
		end
	endgenerate

endmodule
