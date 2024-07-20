module top_module (
	input [7:0] in,
	output parity
);
    // Calculate the parity bit as XOR of all the 8 data bits, for even parity
    assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
endmodule
