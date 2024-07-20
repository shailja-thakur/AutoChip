module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Perform logical AND operation on all bits in 'in'
	assign out_and = in[0] & in[1] & in[2] & in[3];

	// Perform logical OR operation on all bits in 'in'
	assign out_or = in[0] | in[1] | in[2] | in[3];

	// Perform logical XOR operation on all bits in 'in'
	assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule
