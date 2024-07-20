module A (
  input x,
  input y,
  output z
);
  assign z = (x^y) & x;
endmodule
module B (
  input x,
  input y,
  output z
);
  assign #5 z = (x & y) | (~x & ~y);
endmodule
module top_module(
  input x,
  input y,
  output z
);
  A a1 (
    .x(x),
    .y(y),
    .z(w1)
  );
  A a2 (
    .x(x),
    .y(y),
    .z(w2)
  );
  B b1 (
    .x(x),
    .y(y),
    .z(w3)
  );
  B b2 (
    .x(x),
    .y(y),
    .z(w4)
  );
  
  wire w1, w2, w3, w4, w5;
  
  or #(10) or_gate (
    .a(w1),
    .b(w3),
    .z(w5)
  );
  
  and #(10) and_gate (
    .a(w2),
    .b(w4),
    .z(w6)
  );
  
  xor #(10) xor_gate (
    .a(w5),
    .b(w6),
    .z(z)
  );
endmodule
