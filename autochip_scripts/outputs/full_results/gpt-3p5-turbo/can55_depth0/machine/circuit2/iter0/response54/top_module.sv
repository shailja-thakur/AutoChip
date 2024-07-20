module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
    
  wire xor_out;
  
  assign xor_out = a ^ b ^ c ^ d;
  assign q = ~xor_out;

endmodule
