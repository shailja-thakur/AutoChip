module top_module(
  input x,
  input y,
  output z
);
  reg z_reg;
  
  always @* begin
    if(x && y) begin
      z_reg <= 1'b1;
    end else begin
      z_reg <= 1'b0;
    end
  end
  
  assign z = z_reg;
  
endmodule
