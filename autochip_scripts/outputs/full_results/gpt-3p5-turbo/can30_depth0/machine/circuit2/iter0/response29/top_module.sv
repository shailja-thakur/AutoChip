module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

/* XOR operation */
assign temp = a ^ b ^ c ^ d;

/* Invert the output */
assign q = ~temp;

endmodule
