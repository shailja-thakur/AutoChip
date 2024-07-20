module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

assign out_and = &in;        // AND all bits in the input vector
assign out_or = |in;         // OR all bits in the input vector
assign out_xor = ^in;        // XOR all bits in the input vector

endmodule
