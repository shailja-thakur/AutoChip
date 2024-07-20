module top_module (
	input [7:0] in,
	output parity
);

	// XOR gate is used for computing the parity bit
	wire xor_out;
	assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
	// Parity bit is the output of the XOR gate
	assign parity = xor_out;

endmodule
