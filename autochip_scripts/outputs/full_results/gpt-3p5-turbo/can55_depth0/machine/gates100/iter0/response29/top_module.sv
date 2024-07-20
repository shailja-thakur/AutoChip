module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	/* Perform logical AND operation on input */
	assign out_and = &in;

	/* Perform logical OR operation on input */
	assign out_or = |in;

	/* Perform logical XOR operation on input */
	assign out_xor = ^in;

endmodule
