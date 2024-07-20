module top_module(
  input a, 
  input b,
  output out
);

  // Implement NOR gate logic
  assign out = ~(a | b);

endmodule
