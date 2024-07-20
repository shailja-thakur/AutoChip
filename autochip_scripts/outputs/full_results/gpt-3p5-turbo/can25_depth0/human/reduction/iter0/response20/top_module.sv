module top_module (
	input [7:0] in,
	output parity
);

	// Wire declaration for the XOR gate
	wire [7:0] xor_output;

	// Parity bit computation using XOR gate
	assign xor_output = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Assign parity bit to output wire
	assign parity = xor_output;

endmodule
