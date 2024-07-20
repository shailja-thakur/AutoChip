module top_module (
	input [7:0] in,
	output parity
);
	// Wire to store the XOR of all 8 data bits
	wire xor_result;

	// Compute the XOR of all 8 data bits
	assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Assign the parity bit as the XOR result
	assign parity = xor_result;
endmodule
