module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  // Internal wire to hold the XORed value of inputs a, b, c, and d
  wire xor_result;
  
  // XOR operation for inputs a, b, c, and d
  assign xor_result = a ^ b ^ c ^ d;
  
  // Inverted output
  assign q = ~xor_result;

endmodule
