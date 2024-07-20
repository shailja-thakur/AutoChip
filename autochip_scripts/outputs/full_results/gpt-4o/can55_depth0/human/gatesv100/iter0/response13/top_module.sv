module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// (1) out_both: Each bit indicates if both the corresponding input bit and its neighbour to the left are '1'
	genvar i;
	generate 
		for (i = 0; i < 99; i = i + 1) begin : both_gen
			assign out_both[i] = in[i] & in[i+1];
		end
	endgenerate

	// (2) out_any: Each bit indicates if any of the corresponding input bit and its neighbour to the right are '1'
	generate 
		for (i = 1; i < 100; i = i + 1) begin : any_gen
			assign out_any[i] = in[i] | in[i-1];
		end
	endgenerate

	// (3) out_different: Each bit indicates whether the input bit is different from its neighbour to the left (wrapping around)
	assign out_different[99] = in[99] ^ in[0];
	generate 
		for (i = 0; i < 99; i = i + 1) begin : different_gen
			assign out_different[i] = in[i] ^ in[i+1];
		end
	endgenerate

endmodule
