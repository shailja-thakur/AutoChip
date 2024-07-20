module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Logical AND operation
	assign out_and = in[0] & in[1] & in[2] & in[3];
	
	// Logical OR operation
	assign out_or = in[0] | in[1] | in[2] | in[3];
	
	// Logical XOR operation
	assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule
