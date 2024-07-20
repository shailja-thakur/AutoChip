module top_module (
	input [7:0] in,
	output parity
);

	// Intermediate signal to store the XOR of all input bits
	wire [7:0] xor_result;
	
	// XOR all the input bits
	assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
	// Calculate the parity bit (the 9th bit)
	assign parity = xor_result;

endmodule
