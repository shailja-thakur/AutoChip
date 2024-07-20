module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  reg or_ab, or_cd; // declare registers for OR gates
  
  assign or_ab = a | b; // compute OR of inputs a and b
  assign or_cd = c | d; // compute OR of inputs c and d
  
  assign q = or_ab & or_cd; // compute AND of or_ab and or_cd

endmodule
