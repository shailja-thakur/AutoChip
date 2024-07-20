module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  // Outputs q will be high if either input b or input c is high.
  assign q = b | c;

endmodule
