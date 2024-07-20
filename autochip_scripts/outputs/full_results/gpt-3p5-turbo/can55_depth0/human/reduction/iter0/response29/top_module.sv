module top_module (
	input [7:0] in,
	output parity
);

	// Internal signal for parity bit
	reg parity_bit;
	
	// Assign the parity bit as the XOR of all input bits
	assign parity = parity_bit;
	
	// XOR all input bits to compute the parity bit
	always @*
	begin
		parity_bit = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	end
	
endmodule
