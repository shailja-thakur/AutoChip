module top_module (
	input [7:0] in,
	output parity
);

	// Create a wire to store the result of the bitwise XOR operation
	wire xor_result;

	// Perform the bitwise XOR operation on the input port
	assign xor_result = ^in;

	// Assign the result of the bitwise XOR operation to the output port
	assign parity = xor_result;

endmodule
