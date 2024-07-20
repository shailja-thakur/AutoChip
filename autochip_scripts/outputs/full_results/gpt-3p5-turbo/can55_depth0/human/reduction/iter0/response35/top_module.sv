module top_module (
	input [7:0] in,
	output parity
);

	// Internal wires
	wire xor_result;

	// Parity bit calculation
	assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Output assignment
	assign parity = xor_result;

endmodule
