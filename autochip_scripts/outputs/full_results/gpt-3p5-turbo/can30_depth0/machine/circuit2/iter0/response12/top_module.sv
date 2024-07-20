module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// XOR operation of the inputs
	assign q = ~(a ^ b ^ c ^ d);

endmodule
