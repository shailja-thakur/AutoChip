module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Perform a bitwise XOR operation on the inputs
	assign q = a ^ b ^ c ^ d;
	
	// Invert the result
	assign q = ~q;
endmodule
