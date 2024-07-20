module top_module (
	input [7:0] in,
	output parity
);

	// Declare internal wire to store XOR of all data bits
	wire xor_out;

	// Compute XOR of all data bits
	assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Parity bit is the XOR of all data bits
	assign parity = xor_out;

endmodule
