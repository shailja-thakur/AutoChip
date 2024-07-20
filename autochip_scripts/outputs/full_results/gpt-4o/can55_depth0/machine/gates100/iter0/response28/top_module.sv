module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// AND operation: logical AND of all the bits in the input vector
	assign out_and = &in;

	// OR operation: logical OR of all the bits in the input vector
	assign out_or = |in;

	// XOR operation: logical XOR of all the bits in the input vector
	assign out_xor = ^in;

endmodule
