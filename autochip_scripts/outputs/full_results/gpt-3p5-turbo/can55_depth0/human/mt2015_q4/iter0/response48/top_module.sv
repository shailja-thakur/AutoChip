module A (
  input x,
  input y,
  output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
  input x,
  input y,
  output z
);
  reg z;
  always @ (x, y) begin
    case({x,y})
      {1'b0, 1'b0}: z = 1'b1;
      {1'b0, 1'b1}: z = 1'b0;
      {1'b1, 1'b0}: z = 1'b0;
      {1'b1, 1'b1}: z = 1'b1;
    endcase
  end
  assign z = z;
endmodule
module top_module(
  input x,
  input y,
  output z
);
  A a1(.x(x), .y(y), .z(z1));
  A a2(.x(x), .y(y), .z(z2));
  B b1(.x(x), .y(y), .z(z3));
  B b2(.x(x), .y(y), .z(z4));
  or or_gate(.a(z1), .b(z3), .z(z_or));
  and and_gate(.a(z2), .b(z4), .z(z_and));
  xor xor_gate(.a(z_or), .b(z_and), .z(z));
endmodule
