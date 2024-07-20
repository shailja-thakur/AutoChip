module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// out_both[i] = in[i] & in[i+1] for i = 0 to 98
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin
			assign out_both[i] = in[i] & in[i+1];
		end
	endgenerate

	// out_any[i] = in[i] | in[i-1] for i = 1 to 99
	generate
		for (i = 1; i < 100; i = i + 1) begin
			assign out_any[i] = in[i] | in[i-1];
		end
	endgenerate

	// out_different[i] = in[i] ^ in[i-1] for i = 1 to 99
	// out_different[0] = in[0] ^ in[99]
	assign out_different[0] = in[0] ^ in[99];
	generate
		for (i = 1; i < 100; i = i + 1) begin
			assign out_different[i] = in[i] ^ in[i-1];
		end
	endgenerate

endmodule
