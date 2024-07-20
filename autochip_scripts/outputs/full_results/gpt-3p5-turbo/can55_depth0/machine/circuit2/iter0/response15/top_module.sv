module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  // Perform bitwise XOR on inputs
  wire xor_output = a ^ b ^ c ^ d;
  
  // Invert the result
  assign q = ~xor_output;
  
endmodule
