module top_module(
  input x,
  input y,
  output z);

  wire a, b;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  and gate2(b, x, y);     // b = x AND y

  // Third gate
  or gate3(z, a, b);      // z = a OR b

endmodule
