module top_module(
  input x,
  input y,
  output z
);

  reg z_reg;
  
  always @(*)
    begin
      if (x && y)
        z_reg <= 1;
      else
        z_reg <= 0;
    end
    
  assign z = z_reg;
  
endmodule
