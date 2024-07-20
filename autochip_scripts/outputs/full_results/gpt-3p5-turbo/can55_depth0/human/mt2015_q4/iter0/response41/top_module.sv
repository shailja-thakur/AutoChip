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

  assign z = #5 (x & y);

endmodule
module top_module (
  input x,
  input y,
  output z
);

  wire a_out1, a_out2, b_out1, b_out2;
  wire or_out, and_out;

  A a1(
    .x(x),
    .y(y),
    .z(a_out1)
  );

  A a2(
    .x(x),
    .y(y),
    .z(a_out2)
  );

  B b1(
    .x(x),
    .y(y),
    .z(b_out1)
  );

  B b2(
    .x(x),
    .y(y),
    .z(b_out2)
  );

  or #(5) or1(
    .in1(a_out1),
    .in2(b_out1),
    .out(or_out)
  );

  and #(5) and1(
    .in1(a_out2),
    .in2(b_out2),
    .out(and_out)
  );

  xor #(5) xor1(
    .in1(or_out),
    .in2(and_out),
    .out(z)
  );

endmodule
