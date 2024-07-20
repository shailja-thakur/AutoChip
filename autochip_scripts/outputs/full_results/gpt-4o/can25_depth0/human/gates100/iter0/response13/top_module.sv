module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	assign out_and = &in; // Reductions AND of all bits in 'in'
	assign out_or = |in;  // Reductions OR of all bits in 'in'
	assign out_xor = ^in; // Reductions XOR of all bits in 'in'

endmodule
