module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire xor_output;
  
  // XOR gate to perform bitwise XOR on inputs
  assign xor_output = a ^ b ^ c ^ d;
  
  // Inverter to invert the result of XOR operation
  assign q = ~xor_output;
  
endmodule
