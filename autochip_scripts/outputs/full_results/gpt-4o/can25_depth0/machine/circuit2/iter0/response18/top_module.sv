module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Perform bitwise XOR on inputs and then invert the result
	assign q = ~ (a ^ b ^ c ^ d);

endmodule
