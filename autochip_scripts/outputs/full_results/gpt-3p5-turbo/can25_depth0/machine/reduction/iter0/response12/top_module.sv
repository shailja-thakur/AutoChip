module top_module (
	input [7:0] in,
	output parity
);

	// Declare a wire for the bitwise XOR operation
	wire xor_result;

	// Perform the bitwise XOR operation on the input
	assign xor_result = ^in;

	// Assign the output port to the XOR result
	assign parity = xor_result;

endmodule
