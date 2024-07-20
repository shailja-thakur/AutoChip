module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  or gate1(a, x, y);     // a = x OR y

  // Second gate
  not gate2(b, x);      // b = NOT x

  // Third gate
  and gate3(c, a, b);      // c = a AND b
  
  // Fourth gate
  buf gate4(z, c);       // z = c

endmodule
