module top_module (
	input [7:0] in,
	output parity
);

    assign parity = ^in; // XOR of all 8 data bits to generate the even parity bit

endmodule
