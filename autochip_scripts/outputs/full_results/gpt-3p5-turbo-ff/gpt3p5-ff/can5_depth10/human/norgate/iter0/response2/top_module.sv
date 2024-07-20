module top_module(
  input a,
  input b,
  output out
); 

  // logic statement for NOR gate
  assign out = ~(a | b);

endmodule
