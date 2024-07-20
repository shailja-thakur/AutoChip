module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Generation of out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left are '1'.
	// Since in[99] has no neighbour to the left, we calculate for out_both[98:0]
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin: out_both_gen
			assign out_both[i] = in[i] & in[i+1];
		end
	endgenerate

	// Generation of out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
	// Since in[0] has no neighbour to the right, we calculate for out_any[99:1]
	generate
		for (i = 1; i < 100; i = i + 1) begin: out_any_gen
			assign out_any[i] = in[i] | in[i-1];
		end
	endgenerate

	// Generation of out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left.
	// For this part, treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0]
	generate
		for (i = 0; i < 99; i = i + 1) begin: out_different_gen
			assign out_different[i] = in[i] ^ in[i+1];
		end
	endgenerate
	assign out_different[99] = in[99] ^ in[0];
	
endmodule
