module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	/* XOR logic */
	assign q = ~(a ^ b ^ c ^ d);

endmodule
