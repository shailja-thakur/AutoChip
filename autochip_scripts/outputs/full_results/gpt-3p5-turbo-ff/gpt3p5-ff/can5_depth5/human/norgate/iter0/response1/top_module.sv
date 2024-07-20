module top_module(
  input a,
  input b,
  output out
);

  // Implement the NOR gate using the logic primitive
  assign out = ~(a | b);

endmodule
