module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Logic for XOR operation on the inputs
	assign q = ~(a ^ b ^ c ^ d);

endmodule
