module top_module (
	input [7:0] in,
	output parity
);

	// Internal signal to hold the computed parity bit
	reg parity_reg;
	
	// Compute the parity bit by XORing all input bits
	assign parity_reg = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
	// Output the computed parity bit
	assign parity = parity_reg;

endmodule
