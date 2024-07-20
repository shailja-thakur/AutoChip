module top_module(
  input a,
  input b,
  input c,
  output out
);
  wire d;

  assign d = (a & ~b & c) | (a & b & c);

  assign out = d;

endmodule
