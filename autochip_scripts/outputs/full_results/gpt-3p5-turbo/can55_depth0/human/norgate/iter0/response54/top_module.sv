module top_module(
  input a,
  input b,
  output wire out
);

  assign out = ~(a | b);

endmodule
