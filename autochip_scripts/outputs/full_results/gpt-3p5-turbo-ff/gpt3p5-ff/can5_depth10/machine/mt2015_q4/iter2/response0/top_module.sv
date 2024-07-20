module top_module(
  input x,
  input y,
  output z);

  wire a, b;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  or gate2(b, x, y);      // b = x OR y

  // Third gate
  and gate3(z, a, b);     // z = a AND b

endmodule
