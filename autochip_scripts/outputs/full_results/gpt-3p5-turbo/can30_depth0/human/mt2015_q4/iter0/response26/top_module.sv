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

  assign z = #(10) {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}[$random];

endmodule
module top_module(
  input x,
  input y,
  output z);

  A a1 (x, y, );
  A a2 (x, y, );
  B b1 (x, y, );
  B b2 (x, y, );

  wire or_out;
  wire and_out;

  or #(2) or_gate (.a(a1.z), .b(b1.z), .z(or_out));
  and #(2) and_gate (.a(a2.z), .b(b2.z), .z(and_out));

  xor xor_gate (.a(or_out), .b(and_out), .z(z));

endmodule
