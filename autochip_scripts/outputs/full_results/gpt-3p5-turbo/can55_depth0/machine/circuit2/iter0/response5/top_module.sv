module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);
  
  wire xor_result;
  
  // XOR operation
  assign xor_result = a ^ b ^ c ^ d;
  
  // Inversion
  assign q = ~xor_result;

endmodule
