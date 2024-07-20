module top_module(
  input x,
  input y,
  output z);

  wire a, b;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  not gate2(ny, y);       // ny = NOT y
  xor gate3(b, x, ny);    // b = x XOR ny

  // Third gate
  or gate4(z, a, b);      // z = a OR b

endmodule
