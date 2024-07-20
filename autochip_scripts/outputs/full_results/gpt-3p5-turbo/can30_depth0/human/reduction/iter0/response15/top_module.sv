module top_module (
	input [7:0] in,
	output parity
);

	// Create a wire to store the XOR result
	wire out_xor;

	// XOR gate to compute the parity bit
	assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Output the parity bit
	assign parity = out_xor;

endmodule
