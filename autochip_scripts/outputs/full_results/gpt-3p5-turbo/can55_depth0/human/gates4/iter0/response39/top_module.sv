module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// And gate
	assign out_and = in[3] & in[2] & in[1] & in[0];

	// Or gate
	assign out_or = in[3] | in[2] | in[1] | in[0];

	// Xor gate
	assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule
