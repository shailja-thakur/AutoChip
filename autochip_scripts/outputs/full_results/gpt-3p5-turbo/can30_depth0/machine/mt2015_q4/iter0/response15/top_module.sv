module top_module(
  input x,
  input y,
  output z);

  wire a, b;

  // First gate
  and u1(
    .a(x),
    .b(y),
    .z(a)
  );

  // Second gate
  and u2(
    .a(y),
    .b(x),
    .z(b)
  );

  // Third gate
  or u3(
    .a(a),
    .b(b),
    .z(z)
  );

endmodule
