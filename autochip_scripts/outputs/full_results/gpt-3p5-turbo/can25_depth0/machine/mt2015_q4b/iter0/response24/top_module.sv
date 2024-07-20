module top_module(
	input x,
	input y,
	output z);

	// Internal wire for the XOR gate
	wire xor_result;
	
	// XOR gate implementation
	assign xor_result = x ^ y;
	
	// Negation of the XOR gate output
	assign z = ~xor_result;

endmodule
