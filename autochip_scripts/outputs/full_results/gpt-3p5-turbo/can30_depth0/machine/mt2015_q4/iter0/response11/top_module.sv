module top_module(
  input x,
  input y,
  output z);
  
  wire a, b;

  // First gate
  and u_and1(
    .a(x),
    .b(y),
    .z(a)
  );

  // Second gate
  or u_or1(
    .a(y),
    .b(x),
    .z(b)
  );

  // Third gate
  or u_or2(
    .a(a),
    .b(b),
    .z(z)
  );
  
endmodule
