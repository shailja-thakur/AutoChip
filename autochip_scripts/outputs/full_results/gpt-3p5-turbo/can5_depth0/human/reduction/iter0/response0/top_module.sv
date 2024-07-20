module top_module (
	input [7:0] in,
	output parity
);

	// Declare wire to store the XOR of all the input bits
	wire xor_output;

	// Perform XOR operation on all input bits
	assign xor_output = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Assign the xor_output to the parity output
	assign parity = xor_output;

endmodule
