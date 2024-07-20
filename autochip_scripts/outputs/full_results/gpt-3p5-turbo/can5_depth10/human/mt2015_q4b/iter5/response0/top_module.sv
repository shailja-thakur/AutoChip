module top_module(
  input x,
  input y,
  output z);

  reg z_reg;

  always @(x or y)
    begin
      z_reg = x & y;
    end

  assign z = z_reg;

endmodule
