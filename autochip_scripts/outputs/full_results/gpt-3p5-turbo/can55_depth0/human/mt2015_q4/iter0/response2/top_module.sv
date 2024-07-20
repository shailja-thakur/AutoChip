module A(
  input x,
  input y,
  output z
);

  assign z = (x ^ y) & x;

endmodule
module B(
  input x,
  input y,
  output z
);

  reg z_reg;

  always @(x or y) begin
    case ({x, y})
      {1'b0, 1'b0}: z_reg = 1'b1;
      {1'b1, 1'b0}: z_reg = 1'b0;
      {1'b0, 1'b1}: z_reg = 1'b0;
      {1'b1, 1'b1}: z_reg = 1'b1;
    endcase
  end

  assign z = z_reg;

endmodule
module top_module(
  input x,
  input y,
  output z
);

  wire a0_z, a1_z, b0_z, b1_z;
  wire or_out, and_out;

  A a0(.x(x), .y(y), .z(a0_z));
  B b0(.x(x), .y(y), .z(b0_z));
  A a1(.x(x), .y(y), .z(a1_z));
  B b1(.x(x), .y(y), .z(b1_z));

  assign or_out = a0_z | b0_z;
  assign and_out = a1_z & b1_z;
  assign z = or_out ^ and_out;

endmodule
