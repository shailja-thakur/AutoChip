module top_module(
  input a, 
  input b,
  output out
);

  // Output is the logical negation of the XOR of the two inputs
  assign out = ~(a ^ b);

endmodule
