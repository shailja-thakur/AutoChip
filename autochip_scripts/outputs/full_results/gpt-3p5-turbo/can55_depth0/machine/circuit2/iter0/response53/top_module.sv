module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  // XOR logic
  wire xor_output = a ^ b ^ c ^ d;

  // Inverter
  assign q = ~xor_output;

endmodule
