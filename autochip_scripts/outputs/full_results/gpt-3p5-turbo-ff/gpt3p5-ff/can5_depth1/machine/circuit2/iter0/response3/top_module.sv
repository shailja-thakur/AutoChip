module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wire to store the result of XOR operation
	wire xor_output;

	// Perform the XOR operation on the inputs
	assign xor_output = a ^ b ^ c ^ d;

	// Invert the result using the negation operator
	assign q = ~xor_output;

endmodule
