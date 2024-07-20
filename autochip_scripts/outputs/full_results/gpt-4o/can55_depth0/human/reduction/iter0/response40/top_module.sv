module top_module (
	input [7:0] in,
	output parity
);

	// Compute the even parity bit by XORing all the data bits together
	assign parity = ^in;

endmodule
