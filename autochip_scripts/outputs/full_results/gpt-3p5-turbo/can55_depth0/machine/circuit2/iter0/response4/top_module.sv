module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Logic for computing the output
	assign q = ~(a ^ b ^ c ^ d);

endmodule
