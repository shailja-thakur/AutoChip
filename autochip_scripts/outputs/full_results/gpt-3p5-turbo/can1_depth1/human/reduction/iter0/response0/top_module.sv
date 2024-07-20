module top_module (
	input [7:0] in,
	output parity
);

	// XOR gate to compute parity bit
	wire [7:0] xor_out;
	assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Parity bit is just the XOR of all 8 data bits
	assign parity = xor_out[0];

endmodule
