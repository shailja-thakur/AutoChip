module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
    // Perform XOR operation on inputs a, b, c, and d
    wire xor_output = a ^ b ^ c ^ d;
    
    // Invert the result of XOR operation
    assign q = ~xor_output;
endmodule
