module top_module (
  input a,
  input b,
  output out_and,
  output out_or,
  output out_xor,
  output out_nand,
  output out_nor,
  output out_xnor,
  output out_anotb
);

  // And Gate
  assign out_and = a & b;

  // Or Gate
  assign out_or = a | b;

  // Xor Gate
  assign out_xor = a ^ b;

  // Nand Gate
  assign out_nand = ~(a & b);

  // Nor Gate
  assign out_nor = ~(a | b);

  // Xnor Gate
  assign out_xnor = ~(a ^ b);

  // And-Not Gate
  assign out_anotb = a & ~b;

endmodule
