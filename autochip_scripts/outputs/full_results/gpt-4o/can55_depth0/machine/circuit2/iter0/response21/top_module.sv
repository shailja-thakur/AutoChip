module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Perform the bitwise XOR operation on the inputs
	wire xor_result;
	assign xor_result = a ^ b ^ c ^ d;

	// Invert the result of the XOR operation
	assign q = ~xor_result;

endmodule
