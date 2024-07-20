module top_module(
  input x,
  input y,
  output z);
  
  wire a, b;
  
  // first gate
  and gate1(
    .a(x),
    .b(y),
    .z1(a)
  );
  
  // second gate
  or gate2(
    .a(y),
    .b(x),
    .z2(b)
  );
  
  // third gate
  xor gate3(
    .a(a),
    .b(b),
    .z(z)
  );
  
endmodule
