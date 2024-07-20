module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// XOR the inputs
	wire xor_output = a ^ b ^ c ^ d;

	// Invert the output
	assign q = ~xor_output;

endmodule
