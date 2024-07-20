module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// AND all bits together
	assign out_and = &in;
	
	// OR all bits together
	assign out_or = |in;

	// XOR all bits together
	assign out_xor = ^in;

endmodule
