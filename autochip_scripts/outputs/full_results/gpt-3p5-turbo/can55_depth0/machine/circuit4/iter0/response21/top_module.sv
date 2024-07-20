module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);
  
  // Implementation of logical OR operation between inputs b and c
  assign q = b || c;

endmodule
