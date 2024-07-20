module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Performing AND operation
	assign out_and = &in;
	
	// Performing OR operation
	assign out_or = |in;
	
	// Performing XOR operation
	assign out_xor = ^in;

endmodule
