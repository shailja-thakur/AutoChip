module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Logic for AND operation
	assign out_and = &in;

	// Logic for OR operation
	assign out_or = |in;

	// Logic for XOR operation
	assign out_xor = ^in;

endmodule
