module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  and gate2(b, y, x);      // b = y AND x

  // Third gate
  or gate3(z, a, b);      // z = a OR b

endmodule
