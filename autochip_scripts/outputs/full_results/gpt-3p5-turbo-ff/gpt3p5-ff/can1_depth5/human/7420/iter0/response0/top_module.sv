module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  reg p1y_reg;
  reg p2y_reg;

  always @(*)
  begin
    p1y_reg = ~(p1[0] & p1[1] & p1[2] & p1[3]);
    p2y_reg = ~(p2[0] & p2[1] & p2[2] & p2[3]);
  end

  assign p1y = p1y_reg;
  assign p2y = p2y_reg;

endmodule
