module top_module (
	input [7:0] in,
	output parity
);

	// Declare internal wire for XOR operation
	wire [7:0] xor_out;

	// Perform XOR operation on all bits of the input
	assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Calculate the parity bit as the XOR of all bits
	assign parity = xor_out;

endmodule
