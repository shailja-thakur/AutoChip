module top_module (
	input [7:0] in,
	output parity
);

	// Declare internal wire for the parity bit
	wire parity_bit;

	// Implement even parity computation
	assign parity_bit = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Output parity bit
	assign parity = parity_bit;

endmodule
