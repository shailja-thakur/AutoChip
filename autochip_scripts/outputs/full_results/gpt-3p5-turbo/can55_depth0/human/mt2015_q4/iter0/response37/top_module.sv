module top_module(
  input x,
  input y,
  output z);

  wire a1_out, a2_out, b1_out, b2_out, or_out, and_out;

  A a1(.x(x), .y(y), .z(a1_out));
  A a2(.x(x), .y(y), .z(a2_out));
  B b1(.x(x), .y(y), .z(b1_out));
  B b2(.x(x), .y(y), .z(b2_out));

  or gate1(.a(a1_out), .b(b1_out), .z(or_out));
  and gate2(.a(a2_out), .b(b2_out), .z(and_out));
  xor gate3(.a(or_out), .b(and_out), .z(z));

endmodule
