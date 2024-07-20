module top_module(
  input x,
  input y,
  output z);

  // XOR gate
  assign z = ~(x ^ y);

endmodule
