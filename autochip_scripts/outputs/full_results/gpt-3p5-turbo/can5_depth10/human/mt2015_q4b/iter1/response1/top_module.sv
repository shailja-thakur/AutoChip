module top_module(
  input x,
  input y,
  output z);

  reg z;

  always @(x or y)
    z = x & y;

endmodule
