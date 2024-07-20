module top_module (
	input [7:0] in,
	output parity
);

    // Calculate the parity bit for even parity
	assign parity = ^in;

endmodule
