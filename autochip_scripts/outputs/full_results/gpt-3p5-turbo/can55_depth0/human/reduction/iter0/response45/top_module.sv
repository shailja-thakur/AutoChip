module top_module (
	input [7:0] in,
	output parity
);

	// Internal wire to compute the parity bit
	wire parity_bit;
	
	// Compute the parity bit using XOR operation
	assign parity_bit = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
	// Assign the parity bit to the output
	assign parity = parity_bit;

endmodule
