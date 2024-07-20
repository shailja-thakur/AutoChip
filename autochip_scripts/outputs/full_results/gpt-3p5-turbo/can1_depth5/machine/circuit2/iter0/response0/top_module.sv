module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Logic gate connections
	assign q = ~(a ^ b ^ c ^ d);

endmodule
