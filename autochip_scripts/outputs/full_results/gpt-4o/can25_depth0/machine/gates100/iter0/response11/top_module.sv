module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Perform the AND operation across all bits in the input vector
	assign out_and = &in;
	
	// Perform the OR operation across all bits in the input vector
	assign out_or = |in;
	
	// Perform the XOR operation across all bits in the input vector
	assign out_xor = ^in;

endmodule
