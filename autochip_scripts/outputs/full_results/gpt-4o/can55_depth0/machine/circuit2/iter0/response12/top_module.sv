module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Perform XOR operation on all inputs and then invert the result
	assign q = ~((a ^ b ^ c ^ d));

endmodule
