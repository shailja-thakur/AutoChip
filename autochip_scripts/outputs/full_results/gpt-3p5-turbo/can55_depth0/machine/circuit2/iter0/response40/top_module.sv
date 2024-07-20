module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire xor_output;

// Perform xor operation on the inputs
assign xor_output = a ^ b ^ c ^ d;

// Invert the result
assign q = ~xor_output;

endmodule
