module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Logic for out_both
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin : out_both_gen
			assign out_both[i] = in[i] & in[i + 1];
		end
	endgenerate

	// Logic for out_any
	generate
		for (i = 1; i < 100; i = i + 1) begin : out_any_gen
			assign out_any[i] = in[i] | in[i - 1];
		end
	endgenerate

	// Logic for out_different
	generate
		for (i = 0; i < 99; i = i + 1) begin : out_different_gen
			assign out_different[i] = in[i] ^ in[i + 1];
		end
		assign out_different[99] = in[99] ^ in[0]; // Wrap around for the last bit
	endgenerate

endmodule
