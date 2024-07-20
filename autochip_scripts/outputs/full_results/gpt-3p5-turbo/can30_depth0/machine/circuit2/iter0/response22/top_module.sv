module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  // Perform the bitwise XOR operation on the inputs
  wire xor1 = a ^ b;
  wire xor2 = c ^ d;
  
  // Perform the bitwise XOR operation on the xor1 and xor2 results
  wire xor3 = xor1 ^ xor2;
  
  // Invert the result of the XOR operation
  assign q = ~xor3;
  
endmodule
