module top_module (
	input [7:0] in,
	output parity
);

	// Internal wire to hold the result of XOR operation
	wire result;

	// XOR gate to compute the parity bit
	assign result = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// Assign the result to the output
	assign parity = result;

endmodule
