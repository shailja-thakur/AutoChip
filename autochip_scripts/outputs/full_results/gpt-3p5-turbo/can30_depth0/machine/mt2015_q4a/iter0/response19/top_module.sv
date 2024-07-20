module top_module(
  input x,
  input y,
  output z);

  xor xor1 (x, y, z1);
  and and1 (x, z1, z);

endmodule
