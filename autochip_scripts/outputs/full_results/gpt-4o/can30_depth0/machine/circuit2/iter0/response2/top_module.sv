module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
    wire xor_result;
    
    assign xor_result = a ^ b ^ c ^ d;
    assign q = ~xor_result;

endmodule
