module top_module (
	input [7:0] in,
	output parity
);

	// Wire to hold the intermediate result
	wire [7:0] xor_result;

	// Compute the XOR of all input bits
	assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Compute the parity bit - XOR of all bits
	assign parity = xor_result[0] ^ xor_result[1] ^ xor_result[2] ^ xor_result[3] ^ xor_result[4] ^ xor_result[5] ^ xor_result[6] ^ xor_result[7];
    
endmodule
