module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  not gate2(b, x);      // b = NOT x

  // Third gate
  or gate3(z, a, b);      // z = a OR b

endmodule
