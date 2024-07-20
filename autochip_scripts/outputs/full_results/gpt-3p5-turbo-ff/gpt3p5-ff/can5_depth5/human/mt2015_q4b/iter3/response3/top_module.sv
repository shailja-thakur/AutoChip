module top_module(
  input x,
  input y,
  output z);

  reg z_reg;

  always @*
    z_reg = (x & y);

  assign z = z_reg;

endmodule
