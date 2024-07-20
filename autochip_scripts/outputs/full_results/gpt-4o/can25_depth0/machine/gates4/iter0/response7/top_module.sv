module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

assign out_and = &in;  // Logical AND reduction of all bits in 'in'
assign out_or = |in;   // Logical OR reduction of all bits in 'in'
assign out_xor = ^in;  // Logical XOR reduction of all bits in 'in'

endmodule
