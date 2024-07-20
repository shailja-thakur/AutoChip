module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Intermediate wire to hold the result for each bit
	wire [98:0] both;
	wire [99:1] any;
	wire [99:0] different;

	// Logic for out_both
	assign out_both = both;

	// Logic for out_any
	assign out_any = any;

	// Logic for out_different
	assign out_different = different;

	// Logic to compute out_both
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin : compute_both
			assign both[i] = in[i] & in[i+1];
		end
	endgenerate

	// Logic to compute out_any
	genvar j;
	generate
		for (j = 1; j < 100; j = j + 1) begin : compute_any
			assign any[j] = in[j] | in[j-1];
		end
	endgenerate

	// Logic to compute out_different
	assign different[0] = in[99] != in[0];
	genvar k;
	generate
		for (k = 1; k < 100; k = k + 1) begin : compute_different
			assign different[k] = in[k] != in[k-1];
		end
	endgenerate

endmodule
