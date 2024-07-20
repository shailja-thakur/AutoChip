module top_module (
	input [7:0] in,
	output parity
);

assign parity = ^in;  // XOR all bits in 'in' to compute the even parity bit

endmodule
