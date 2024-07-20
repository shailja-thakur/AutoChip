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
  
  assign #5 {z, z, z, z, z, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0} = 1'b1;
  
endmodule
module top_module(
  input x,
  input y,
  output z);
  
  wire a_out, b_out;
  A a1(.x(x), .y(y), .z(a_out));
  B b1(.x(x), .y(y), .z(b_out));
  A a2(.x(x), .y(y), .z(a_out));
  B b2(.x(x), .y(y), .z(b_out));
  
  assign z = a_out ^ b_out;
  
endmodule
