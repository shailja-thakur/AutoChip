module top_module (
	input [7:0] in,
	output parity
);
    assign parity = ^in; // XOR all bits in the 8-bit input to get the parity bit for even parity
endmodule
