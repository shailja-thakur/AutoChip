module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// implementation of logic function
	assign q = ~(a ^ b ^ c ^ d);
	
endmodule
