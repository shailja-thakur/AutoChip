module top_module (
	input [7:0] in,
	output parity
);

	// Calculate the even parity bit
	assign parity = ^in;

endmodule
