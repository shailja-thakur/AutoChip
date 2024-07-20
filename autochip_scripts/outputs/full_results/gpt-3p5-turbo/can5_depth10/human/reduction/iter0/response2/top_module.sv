module top_module (
	input [7:0] in,
	output parity
);
	// Declare internal wire for the XOR operation
	wire xor_output;

	// Assign the XOR output as the parity bit
	assign parity = xor_output;

	// Implement XOR gate to compute the parity bit
	assign xor_output = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
endmodule
