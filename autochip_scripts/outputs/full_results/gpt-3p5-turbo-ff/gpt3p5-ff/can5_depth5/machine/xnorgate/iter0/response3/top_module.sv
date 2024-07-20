module top_module(
  input a,
  input b,
  output out
);

  // Implement the circuit
  assign out = ~(a ^ b);

endmodule
