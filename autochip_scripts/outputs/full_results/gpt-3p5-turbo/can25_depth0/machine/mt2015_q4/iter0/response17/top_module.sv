module top_module(
  input x,
  input y,
  output z);

  wire a1, a2, b3;

  // First gate
  and gate1(a1, x, y);

  // Second gate
  or gate2(a2, x, y);

  // Third gate
  xor gate3(z, a1, a2);

endmodule
