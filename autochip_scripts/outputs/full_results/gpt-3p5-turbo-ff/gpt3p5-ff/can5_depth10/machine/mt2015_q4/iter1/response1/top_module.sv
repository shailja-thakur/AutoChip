module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  or gate2(b, x, y);      // b = x OR y

  // Third gate
  or gate3(c, a, b);      // c = a OR b

  assign z = c;

endmodule
