module top_module(
  input p1a, 
  input p1b, 
  input p1c, 
  input p1d, 
  output p1y, 
  input p2a, 
  input p2b, 
  input p2c, 
  input p2d, 
  output p2y
);

  reg p1y_reg;
  reg p2y_reg;

  always @(*)
  begin
    p1y_reg = ~(p1a & p1b & p1c & p1d);
    p2y_reg = ~(p2a & p2b & p2c & p2d);
  end

  assign p1y = p1y_reg;
  assign p2y = p2y_reg;

endmodule
