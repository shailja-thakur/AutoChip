module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    assign out_and = &in;  // AND reduction operator for all bits in 'in'
    assign out_or = |in;   // OR reduction operator for all bits in 'in'
    assign out_xor = ^in;  // XOR reduction operator for all bits in 'in'
endmodule
