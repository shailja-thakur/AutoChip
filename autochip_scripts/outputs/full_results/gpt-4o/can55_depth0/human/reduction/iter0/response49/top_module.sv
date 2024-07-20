module top_module (
	input [7:0] in,
	output parity
);

	// Compute the parity bit for even parity
	assign parity = ^in;

endmodule
