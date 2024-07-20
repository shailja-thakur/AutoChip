module top_module (
	input [7:0] in,
	output parity
);

	// Intermediate wire to hold the XOR of all input bits
	wire xor_result;

	// Compute the XOR of all input bits
	assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Output the parity bit
	assign parity = xor_result;

endmodule
