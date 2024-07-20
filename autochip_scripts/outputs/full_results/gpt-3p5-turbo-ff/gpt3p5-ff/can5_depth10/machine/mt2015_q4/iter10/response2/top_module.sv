module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  xor gate1(a, x, y);     // a = x XOR y

  // Second gate
  xor gate2(b, x, y);      // b = x XOR y

  // Third gate
  or gate3(c, a, b);      // c = a OR b

  // Fourth gate
  assign z = c;           // z = c

endmodule
