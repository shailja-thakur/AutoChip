module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);
  
  // intermediate wire to store the XOR result
  wire xor_result;
  
  // XOR operation between the inputs
  assign xor_result = a ^ b ^ c ^ d;
  
  // inverting the XOR result to get the final output 
  assign q = ~xor_result;

endmodule
