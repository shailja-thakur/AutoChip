module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	
	// out_both
	assign out_both[0] = in[0] & in[99];
	
	generate
		genvar i;
		for (i = 1; i < 99; i = i + 1) begin : BOTH
			assign out_both[i] = in[i] & in[i-1];
		end
	endgenerate

	// out_any
	assign out_any[99] = in[98] | in[99];
	
	generate
		genvar j;
		for (j = 0; j < 99; j = j + 1) begin : ANY
			assign out_any[j] = in[j+1] | in[j];
		end
	endgenerate

	// out_different
	assign out_different[0] = in[0] ^ in[99];
	
	generate
		genvar k;
		for (k = 1; k < 100; k = k + 1) begin : DIFFERENT
			assign out_different[k] = in[k] ^ in[k-1];
		end
	endgenerate

endmodule
