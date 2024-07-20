module top_module(
  input a, 
  input b,
  input c,
  output out
);
  
  wire d;
  
  assign d = (a & b) | (~a & c);
  assign out = d;
  
endmodule
