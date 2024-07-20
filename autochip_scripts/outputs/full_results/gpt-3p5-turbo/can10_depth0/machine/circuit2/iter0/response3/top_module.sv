module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

  wire xor_res;
  
  assign xor_res = a ^ b ^ c ^ d;
  
  assign q = ~xor_res;
  
endmodule
