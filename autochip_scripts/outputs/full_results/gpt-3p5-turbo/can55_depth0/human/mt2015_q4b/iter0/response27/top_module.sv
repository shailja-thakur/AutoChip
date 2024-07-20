module top_module (
  input x,
  input y,
  output z
);
  
  reg x_reg;
  reg y_reg;
  wire z_wire;

  always @(x) begin
    x_reg <= x;
  end

  always @(y) begin
    y_reg <= y;
  end

  assign z_wire = (x_reg & (~y_reg)) | (~x_reg & y_reg);
  assign z = z_wire;

endmodule
