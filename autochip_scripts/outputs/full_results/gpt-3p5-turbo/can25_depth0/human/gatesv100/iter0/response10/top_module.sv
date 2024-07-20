module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire declaration
	wire [98:0] temp_both;
	wire [99:1] temp_any;
	wire [99:0] temp_different;

	// Both Output
	genvar i;
	generate
		for (i = 0; i < 99; i=i+1) begin : BOTH_GEN
			assign temp_both[i] = (in[i] & in[i+1]);
		end
	endgenerate
	assign out_both = temp_both;
	
	// Any Output
	assign temp_any[0] = in[0];
	generate
		for (i = 1; i < 99; i=i+1) begin : ANY_GEN
			assign temp_any[i] = (in[i] | in[i-1]);
		end
	endgenerate
	assign out_any = temp_any;

	// Different Output
	assign temp_different[99] = (in[99] != in[0]);
	generate
		for (i = 0; i < 99; i=i+1) begin : DIFF_GEN
			assign temp_different[i] = (in[i] != in[i+1]);
		end
	endgenerate
	assign out_different = temp_different;

endmodule
