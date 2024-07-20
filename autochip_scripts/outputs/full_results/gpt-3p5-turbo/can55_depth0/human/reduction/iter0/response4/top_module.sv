module top_module (
	input [7:0] in,
	output parity
);

	// wire to store the result of XOR operation
	wire xor_result;
	
	// XOR gate to compute parity bit
	assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
	
	// assign the result of XOR operation to the parity output
	assign parity = xor_result;

endmodule
