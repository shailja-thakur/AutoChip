module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Logic for XOR operation
wire xor_result;
assign xor_result = a ^ b ^ c ^ d;

// Invert the xor_result
assign q = ~xor_result;

endmodule
