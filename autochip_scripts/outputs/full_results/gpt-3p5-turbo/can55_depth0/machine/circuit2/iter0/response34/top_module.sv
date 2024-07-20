module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Wire to store the bitwise XOR result
	wire xor_result;
	
	// Intermediate wire to store the inverted result
	wire inverted_result;
	
	// Perform bitwise XOR operation on the inputs
	assign xor_result = a ^ b ^ c ^ d;
	
	// Invert the result using the bitwise negation operator (~)
	assign inverted_result = ~xor_result;
	
	// Assign the inverted result to the output q
	assign q = inverted_result;

endmodule
