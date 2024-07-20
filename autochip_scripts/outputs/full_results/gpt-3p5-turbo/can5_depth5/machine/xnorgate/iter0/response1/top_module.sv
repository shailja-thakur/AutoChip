module top_module(
  input a,
  input b,
  output out
);

  // Assign statement to implement XOR and logical negation
  assign out = ~(a ^ b);

endmodule
