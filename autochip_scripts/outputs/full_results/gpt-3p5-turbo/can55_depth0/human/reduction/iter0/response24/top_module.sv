module top_module (
	input [7:0] in,
	output parity
);
	// Wire for storing the computed parity bit
	wire parity_bit;

	// Compute the parity bit using XOR gate
	assign parity_bit = ^in;

	// Output the computed parity bit
	assign parity = parity_bit;

endmodule
