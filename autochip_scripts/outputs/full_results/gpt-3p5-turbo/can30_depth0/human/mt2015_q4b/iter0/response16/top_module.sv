module top_module(
  input x,
  input y,
  output z);

  reg z_reg;

  always @(x or y) begin
    case ({x, y})
      2'b00: z_reg <= 1;
      2'b01: z_reg <= 0;
      2'b10: z_reg <= 0;
      2'b11: z_reg <= 1;
    endcase
  end

  assign z = z_reg;

endmodule
