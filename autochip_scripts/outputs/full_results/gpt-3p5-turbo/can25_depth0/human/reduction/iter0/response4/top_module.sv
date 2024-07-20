module top_module (
	input [7:0] in,
	output parity
);

// Wire to store the XOR of all input bits
wire xor_output;

// XOR all input bits to compute parity
assign xor_output = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

// Output the parity bit
assign parity = xor_output;

endmodule
