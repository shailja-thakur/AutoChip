module A(
  input x,
  input y,
  output z);
  
  assign z = (x ^ y) & x;

endmodule
module B(
  input x,
  input y,
  output z);
  
  assign #5 z = (x & !y) | (!x & y);

endmodule
module top_module(
  input x,
  input y,
  output z);

  A A1 (x, y, z_A1);
  A A2 (x, y, z_A2);
  B B1 (x, y, z_B1);
  B B2 (x, y, z_B2);

  or #(0,90,5) or_gate (z_A1, z_B1, z_or);
  or #(0,90,5) and_gate (z_A2, z_B2, z_and);
  xor #(0,90,5) xor_gate (z_or, z_and, z);

endmodule
