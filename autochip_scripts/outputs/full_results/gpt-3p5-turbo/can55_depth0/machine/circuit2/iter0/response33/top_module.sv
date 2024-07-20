module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// XOR operation
	assign q = ~(a ^ b ^ c ^ d);
endmodule
