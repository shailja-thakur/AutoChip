module top_module (
	input [7:0] in,
	output parity
);

	// assign the parity bit by performing a bitwise XOR operation on the input
	assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
endmodule
