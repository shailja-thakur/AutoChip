module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Assign out_and to the result of a logical AND operation on all of the bits in in[3:0]
	assign out_and = in[3] & in[2] & in[1] & in[0];

	// Assign out_or to the result of a logical OR operation on all of the bits in in[3:0]
	assign out_or = in[3] | in[2] | in[1] | in[0];

	// Assign out_xor to the result of a logical XOR operation on all of the bits in in[3:0]
	assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule
