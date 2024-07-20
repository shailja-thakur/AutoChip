module A(
  input x,
  input y,
  output z);
  
  assign z = (x ^ y) & x;
endmodule
module B(
  input x,
  input y,
  output z);
  
  assign #5 z = (x & ~y) | (~x & y);
endmodule
module top_module(
  input x,
  input y,
  output z);
  
  wire a1, a2, b1, b2, or_out, and_out;
  
  A inst_a1 (.x(x), .y(y), .z(a1));
  A inst_a2 (.x(x), .y(y), .z(a2));
  
  B inst_b1 (.x(x), .y(y), .z(b1));
  B inst_b2 (.x(x), .y(y), .z(b2));
  
  assign or_out = a1 | b1;
  assign and_out = a2 & b2;
  assign z = or_out ^ and_out;
endmodule
