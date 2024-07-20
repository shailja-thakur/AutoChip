module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wire for the XOR result
	wire xor_result;
	
	// XOR operation on all inputs
	assign xor_result = a ^ b ^ c ^ d;
	
	// Invert the XOR result to get the final output
	assign q = ~xor_result;

endmodule
