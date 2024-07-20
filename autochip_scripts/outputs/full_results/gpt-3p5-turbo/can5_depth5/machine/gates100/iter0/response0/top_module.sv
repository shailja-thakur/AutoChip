module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	/* Perform logical AND on input vector */
	assign out_and = &in;

	/* Perform logical OR on input vector */
	assign out_or = |in;

	/* Perform logical XOR on input vector */
	assign out_xor = ^in;

endmodule
