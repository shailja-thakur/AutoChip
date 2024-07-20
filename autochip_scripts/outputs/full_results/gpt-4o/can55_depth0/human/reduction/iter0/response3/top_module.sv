module top_module (
	input [7:0] in,
	output parity
);
    assign parity = ^in; // XOR all 8 bits in 'in' to produce the parity bit
endmodule
