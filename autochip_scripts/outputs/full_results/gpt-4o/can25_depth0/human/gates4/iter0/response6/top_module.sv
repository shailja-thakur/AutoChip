module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	assign out_and = &in; // AND all bits of the input
	assign out_or = |in;   // OR all bits of the input
	assign out_xor = ^in;  // XOR all bits of the input

endmodule
