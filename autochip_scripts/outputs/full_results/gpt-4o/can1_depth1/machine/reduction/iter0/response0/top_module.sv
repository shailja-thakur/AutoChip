module top_module (
	input [7:0] in,
	output parity
);

assign parity = ^in; // XOR reduce operator, computes parity of all bits in 'in'

endmodule
