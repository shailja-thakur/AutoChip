module top_module(
  input a,
  input b,
  output out
);

  // Implementation of logic circuit
  assign out = ~(a ^ b);

endmodule
