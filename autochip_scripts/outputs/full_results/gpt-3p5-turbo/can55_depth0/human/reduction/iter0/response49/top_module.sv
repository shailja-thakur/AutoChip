module top_module (
	input [7:0] in,
	output parity
);

	// Wire to compute the parity bit
	wire par;

	// Compute the parity bit using XOR gate
	assign par = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// Assign the parity bit to the output
	assign parity = par;

endmodule
