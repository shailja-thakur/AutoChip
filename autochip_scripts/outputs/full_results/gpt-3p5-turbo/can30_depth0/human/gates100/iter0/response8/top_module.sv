module top_module(
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  // and gate
  assign out_and = &in;

  // or gate
  assign out_or = |in;

  // xor gate
  assign out_xor = ^in;

endmodule
