module top_module(
  input x,
  input y,
  output z
);
  reg z_reg;
  
  always @(x or y)
  begin
    if (x && !y)
      z_reg <= 0;
    else if (!x && y)
      z_reg <= 0;
    else if (x && y)
      z_reg <= 1;
  end
  
  assign z = z_reg;
  
endmodule
