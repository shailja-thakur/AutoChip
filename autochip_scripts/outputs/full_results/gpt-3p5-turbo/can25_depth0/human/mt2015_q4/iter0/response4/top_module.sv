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
  reg z;

  always @(x or y)
    case({x, y})
      0: z = 1;
      1: z = 0;
    endcase
endmodule
module top_module(
  input x,
  input y,
  output z
);
  wire a_out, b_out;

  A a1(.x(x), .y(y), .z(a_out));
  A a2(.x(x), .y(y), .z(b_out));
  B b1(.x(x), .y(y), .z(a_out));
  B b2(.x(x), .y(y), .z(b_out));

  assign z = a_out ^ b_out;
endmodule
