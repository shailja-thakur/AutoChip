module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	assign out_and = in[0] & in[1] & ... & in[99];
	assign out_or = in[0] | in[1] | ... | in[99];
	assign out_xor = in[0] ^ in[1] ^ ... ^ in[99];

endmodule
