module A(
  input x,
  input y,
  output z_a);

  assign z_a = (x ^ y) & x;

endmodule
module B(
  input x,
  input y,
  output z_b);

  always @(x or y) begin
    case({x, y})
      2'b00: z_b = 1;
      2'b01: z_b = 0;
      2'b10: z_b = 0;
      2'b11: z_b = 1;
      default: z_b = 0;
    endcase
  end

endmodule
module top_module(
  input x,
  input y,
  output z);

  wire a_z1, b_z1, a_z2, b_z2;

  A a1(.x(x), .y(y), .z_a(a_z1));
  A a2(.x(x), .y(y), .z_a(a_z2));
  B b1(.x(x), .y(y), .z_b(b_z1));
  B b2(.x(x), .y(y), .z_b(b_z2));

  assign z = a_z1 | b_z1 ^ a_z2 & b_z2;

endmodule
