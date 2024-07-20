module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  // Use an intermediate wire to store the result of the XOR operation
  wire xor_result = a ^ b ^ c ^ d;

  // Use a not gate to invert the result
  assign q = ~xor_result;

endmodule
