module top_module (
	input [7:0] in,
	output parity
);
	assign parity = ^in;     // XOR all 8 data bits to get parity bit
endmodule
