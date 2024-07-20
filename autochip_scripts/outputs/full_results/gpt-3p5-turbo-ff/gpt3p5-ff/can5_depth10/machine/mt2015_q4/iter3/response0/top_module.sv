module top_module(
  input x,
  input y,
  output z);

  wire a, b;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  xor gate2(b, x, y);      // b = x XOR y

  // Third gate
  or gate3(z, a, b);      // z = a OR b


  // Add a buffer to propagate the values of a and b to the third gate
  buf buf_a(a, z);
  buf buf_b(b, z);

endmodule
