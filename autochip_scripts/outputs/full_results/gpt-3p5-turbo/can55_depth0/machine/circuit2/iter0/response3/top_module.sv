module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  wire xor_result;
  wire inverted_result;
  
  // XOR operation
  assign xor_result = a ^ b ^ c ^ d;
  
  // Invert the result
  assign inverted_result = ~xor_result;
  
  // Output
  assign q = inverted_result;

endmodule
