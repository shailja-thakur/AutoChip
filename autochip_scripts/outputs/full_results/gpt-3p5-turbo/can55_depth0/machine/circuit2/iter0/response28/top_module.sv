module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wire to store the XOR result
	wire xor_result;

	// Perform XOR operation on the inputs
	assign xor_result = a ^ b ^ c ^ d;

	// Invert the result to get the final output
	assign q = ~xor_result;

endmodule
