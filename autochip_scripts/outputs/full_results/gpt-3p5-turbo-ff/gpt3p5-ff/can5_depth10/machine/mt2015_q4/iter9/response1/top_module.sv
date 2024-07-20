module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  xor gate2(b, x, y);      // b = x XOR y

  // Third gate
  buf gate3(c, a);      // c = a
  
  // Fourth gate
  buf gate4(z, c);       // z = c
  
endmodule
