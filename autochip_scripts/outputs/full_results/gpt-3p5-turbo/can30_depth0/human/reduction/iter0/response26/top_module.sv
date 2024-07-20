module top_module (
	input [7:0] in,
	output parity
);

	// Internal signal to store the computed parity bit
	wire parity_bit;

	// XOR gate to compute the parity bit
	assign parity_bit = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// Output the computed parity bit
	assign parity = parity_bit;

endmodule
