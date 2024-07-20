module A(
  input wire x,
  input wire y,
  output wire z
);

  assign z = (x ^ y) & x;
  
endmodule
module B(
  input wire x,
  input wire y,
  output wire z
);

  assign z = (x & y) | (x ^ y);

endmodule
module top_module(
  input x,
  input y,
  output z
);

  wire a1_z, a2_z, b1_z, b2_z;
  
  A a1(.x(x), .y(y), .z(a1_z));
  B b1(.x(x), .y(y), .z(b1_z));
  
  A a2(.x(x), .y(y), .z(a2_z));
  B b2(.x(x), .y(y), .z(b2_z));
  
  wire or_out = a1_z | b1_z;
  wire and_out = a2_z & b2_z;

  assign z = or_out ^ and_out;

endmodule
