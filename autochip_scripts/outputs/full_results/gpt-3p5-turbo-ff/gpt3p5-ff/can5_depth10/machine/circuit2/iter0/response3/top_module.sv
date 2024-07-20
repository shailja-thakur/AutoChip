module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// XOR operation on the inputs
	assign q = a ^ b ^ c ^ d;
	// Inverting the result
	assign q = ~q;
endmodule
