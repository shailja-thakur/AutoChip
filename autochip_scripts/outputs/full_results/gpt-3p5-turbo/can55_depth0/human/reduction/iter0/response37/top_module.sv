module top_module (
	input [7:0] in,
	output parity
);

	// Internal wire to store the parity bit
	wire parity_bit;
	
	// Parity bit calculation using XOR gate
	assign parity_bit = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
	// Output connection for the parity bit
	assign parity = parity_bit;

endmodule
