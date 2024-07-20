module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Perform bitwise XOR operation on the inputs
	wire temp_xor = a ^ b ^ c ^ d;
	
	// Invert the result of the XOR operation
	assign q = ~temp_xor;

endmodule
