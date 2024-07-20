module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Logic to implement the desired functionality
	assign q = ~(a ^ b ^ c ^ d);

endmodule
