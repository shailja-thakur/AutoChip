module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// AND reduction operation
	assign out_and = &in;
	
	// OR reduction operation
	assign out_or = |in;
	
	// XOR reduction operation
	assign out_xor = ^in;

endmodule
