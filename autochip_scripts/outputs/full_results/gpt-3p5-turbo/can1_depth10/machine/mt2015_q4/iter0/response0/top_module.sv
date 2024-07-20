module top_module(
  input x,
  input y,
  output z);

  wire a;
  wire b;

  // First Gate
  and gate_1(a, x, y);

  // Second Gate
  xor gate_2(b, x, y);

  // Third Gate
  or gate_3(z, a, b);

endmodule
