module top_module(
  input a,
  input b,
  output out
);
  
  // Implementing a NOR gate
  assign out = ~(a | b);
  
endmodule
