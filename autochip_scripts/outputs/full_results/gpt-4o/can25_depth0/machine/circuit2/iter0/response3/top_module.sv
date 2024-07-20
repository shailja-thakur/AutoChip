module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	wire xor_result;
	
	// Perform bitwise XOR on the inputs
	assign xor_result = a ^ b ^ c ^ d;
	
	// Invert the result
	assign q = ~xor_result;

endmodule
