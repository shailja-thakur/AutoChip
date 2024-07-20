module top_module (
	input [99:0] in,
	output reg out_and,
	output reg out_or,
	output reg out_xor
);

	/* Perform the logical AND operation */
	// The `&` operator performs the logical AND operation on all bits in the input vector
	assign out_and = &in;
	
	/* Perform the logical OR operation */
	// The `|` operator performs the logical OR operation on all bits in the input vector
	assign out_or = |in;
	
	/* Perform the logical XOR operation */
	// The `^` operator performs the logical XOR operation on all bits in the input vector
	assign out_xor = ^in;

endmodule
