module A (
  input wire x,
  input wire y,
  output wire z
);
  assign z = (x ^ y) & x;
endmodule
module B (
  input wire x,
  input wire y,
  output wire z
);
  assign z = #5 x & y;
endmodule
module top_module (
  input wire x,
  input wire y,
  output wire z
);
  wire a1_out, a2_out, b1_out, b2_out, or_out, and_out;

  A a1(.x(x), .y(y), .z(a1_out));
  B b1(.x(x), .y(y), .z(b1_out));

  A a2(.x(x), .y(y), .z(a2_out));
  B b2(.x(x), .y(y), .z(b2_out));

  assign or_out = a1_out | b1_out;
  assign and_out = a2_out & b2_out;
  assign z = or_out ^ and_out;
endmodule
