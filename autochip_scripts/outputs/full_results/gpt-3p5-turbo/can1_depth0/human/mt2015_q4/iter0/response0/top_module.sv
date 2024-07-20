module A (
    input x,
    input y,
    output z
  );
  
  wire w1;
  wire w2;
  wire w3;
  
  assign w1 = x ^ y;
  assign w2 = w1 & x;
  assign w3 = !(w2);
  
  assign z = w3;
endmodule
module B (
    input x,
    input y,
    output z
  );
  
  wire w1;
  wire w2;
  wire w3;
  
  assign w1 = x;
  assign w2 = y;
  assign w3 = w1 & w2;
  
  assign z = w3;
  
endmodule
module top_module(
  input x,
  input y,
  output z
);
  
  wire a1;
  wire a2;
  wire b1;
  wire b2;
  wire o1;
  wire o2;
  
  A a_inst1(
    .x(x),
    .y(y),
    .z(a1)
  );
  
  A a_inst2(
    .x(x),
    .y(y),
    .z(a2)
  );
  
  B b_inst1(
    .x(x),
    .y(y),
    .z(b1)
  );
  
  B b_inst2(
    .x(x),
    .y(y),
    .z(b2)
  );
  
  or o_inst(
    .a(a1),
    .b(b1),
    .z(o1)
  );
  
  and a_inst(
    .a(a2),
    .b(b2),
    .z(o2)
  );
  
  xor x_inst(
    .a(o1),
    .b(o2),
    .z(z)
  );
  
endmodule
