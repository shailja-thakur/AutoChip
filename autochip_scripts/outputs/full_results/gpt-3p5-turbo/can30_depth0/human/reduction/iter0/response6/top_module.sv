module top_module (
	input [7:0] in,
	output parity
);

	// Wire for storing the calculated parity bit
	wire parity_bit;

	// Parity calculation using XOR gate
	assign parity_bit = ^in;

	// Assigning the calculated parity bit to the output
	assign parity = parity_bit;

endmodule
