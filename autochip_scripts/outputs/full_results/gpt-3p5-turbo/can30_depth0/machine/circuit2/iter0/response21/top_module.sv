module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  wire xor_out;
  
  assign xor_out = a ^ b ^ c ^ d;  // Perform XOR operation on the inputs
  
  assign q = ~xor_out;  // Invert the result of the XOR operation to get the final output
  
endmodule
