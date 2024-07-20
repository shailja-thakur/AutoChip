module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// out_both
	assign out_both[0] = in[0] & in[99];
	
	// Iterate from 1 to 98
	generate
	genvar i;
	for (i = 1; i <= 98; i = i + 1) begin : both_generate
		assign out_both[i] = in[i] & in[i-1];
	end
	endgenerate
	
	// out_any
	assign out_any[99] = in[99] | in[98];
	
	// Iterate from 98 to 1
	generate
	genvar j;
	for (j = 98; j >= 1; j = j - 1) begin : any_generate
		assign out_any[j] = in[j] | in[j-1];
	end
	endgenerate
	
	// out_different
	assign out_different[0] = in[0] != in[99];
	
	// Iterate from 1 to 99
	generate
	genvar k;
	for (k = 1; k <= 99; k = k + 1) begin : different_generate
		assign out_different[k] = in[k] != in[k-1];
	end
	endgenerate
	
endmodule
