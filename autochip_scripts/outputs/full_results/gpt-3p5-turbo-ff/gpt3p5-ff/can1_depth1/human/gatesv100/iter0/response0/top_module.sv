module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire declarations
	wire [98:0] in_prev;
	wire [98:0] in_next;

	// Generate in_prev and in_next vectors
	assign in_prev[98] = in[99];
	assign in_next[0] = in[0];
	genvar i;
	generate
		for (i = 1; i <= 98; i = i+1) begin : generate_block
			assign in_prev[i] = in[i-1];
			assign in_next[i] = in[i];
		end
	endgenerate

	// Generate out_both vector
	genvar j;
	generate
		for (j = 0; j <= 98; j = j+1) begin : generate_block2
			assign out_both[j] = in[j] & in_prev[j];
		end
	endgenerate

	// Generate out_any vector
	genvar k;
	generate
		for (k = 1; k <= 99; k = k+1) begin : generate_block3
			assign out_any[k] = in[k] | in_next[k];
		end
	endgenerate

	// Generate out_different vector
	genvar l;
	generate
		for (l = 0; l <= 98; l = l+1) begin : generate_block4
			assign out_different[l] = (in[l] != in_prev[l]);
		end
	endgenerate

endmodule
