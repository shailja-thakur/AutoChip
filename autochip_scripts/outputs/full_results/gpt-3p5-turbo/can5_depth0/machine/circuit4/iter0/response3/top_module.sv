module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  // Only inputs b and c are used
  assign q = b | c;
  
endmodule
