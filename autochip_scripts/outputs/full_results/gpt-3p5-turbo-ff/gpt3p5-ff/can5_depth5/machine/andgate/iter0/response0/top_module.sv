module top_module(
  input a,
  input b,
  output reg out
);

  always @(a, b)
    out = a & b;

endmodule
