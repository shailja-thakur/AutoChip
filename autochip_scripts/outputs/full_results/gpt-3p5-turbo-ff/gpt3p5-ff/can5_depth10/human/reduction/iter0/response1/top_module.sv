module top_module (
	input [7:0] in,
	output parity
);
	// XOR gate to compute the parity bit
	reg parity_bit;
	always @(*) begin
		parity_bit = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	end
	
	// Output the parity bit
	assign parity = parity_bit;
endmodule
