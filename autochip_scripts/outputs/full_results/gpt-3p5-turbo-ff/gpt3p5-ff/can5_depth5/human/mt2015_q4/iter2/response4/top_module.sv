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
  
  assign #5 z = (x & ~y);
  
endmodule
module top_module(
  input x,
  input y,
  output z
);
  
  wire a1, a2, b1, b2;
  wire or_output, and_output;
  
  A a_inst1(.x(x), .y(y), .z(a1));
  B b_inst1(.x(x), .y(y), .z(b1));
  A a_inst2(.x(x), .y(y), .z(a2));
  B b_inst2(.x(x), .y(y), .z(b2));
  
  assign or_output = a1 | b1;
  assign and_output = a2 & b2;
  assign z = or_output ^ and_output;
  
endmodule
