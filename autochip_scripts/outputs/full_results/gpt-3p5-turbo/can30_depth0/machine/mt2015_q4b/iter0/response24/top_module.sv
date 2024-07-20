module top_module(
  input x,
  input y,
  output z);

  xor gate1(
    .a(x),
    .b(y),
    .o(temp));

  not gate2(
    .a(temp),
    .o(z));

endmodule
module xor(
  input a,
  input b,
  output o);

  assign o = a ^ b;

endmodule
module not(
  input a,
  output o);

  assign o = ~a;

endmodule
