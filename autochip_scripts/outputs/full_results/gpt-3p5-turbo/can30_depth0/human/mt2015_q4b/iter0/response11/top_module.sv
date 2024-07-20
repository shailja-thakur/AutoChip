module top_module(
  input x,
  input y,
  output z);
  
  reg z_reg;
  
  always @(x, y) begin
    case ({x, y})
      2'b01, 2'b10: z_reg <= 1'b0;
      default: z_reg <= 1'b1;
    endcase
  end
  
  assign z = z_reg;
  
endmodule
