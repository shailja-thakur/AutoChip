module top_module(
  input x,
  input y,
  output z
);

  wire a, b;

  and gate1(a, y, x);
  or gate2(b, x, y);
  xor gate3(z, a, b);

endmodule
