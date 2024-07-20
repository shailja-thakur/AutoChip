module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	/* Use an internal wire to perform bitwise XOR operation */
	wire [3:0] xor_out;
	assign xor_out = a ^ b ^ c ^ d;
	
	/* Use a NOT gate to invert the result */
	assign q = ~xor_out;
	
endmodule
