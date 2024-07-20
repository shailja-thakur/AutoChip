module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  nand gate1(a, x, y);     // a = x NAND y

  // Second gate
  nand gate2(b, x, y);      // b = x NAND y

  // Third gate
  nand gate3(c, a, b);      // c = a NAND b
  
  // Fourth gate
  not gate4(z, c);       // z = NOT c

endmodule
