module top_module (
	input [7:0] in,
	output parity
);
    assign parity = ^in;  // XOR all bits in 'in' to get the even parity bit
endmodule
