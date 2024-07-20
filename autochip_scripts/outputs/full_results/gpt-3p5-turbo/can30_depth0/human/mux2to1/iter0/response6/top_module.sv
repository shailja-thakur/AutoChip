module top_module(
  input a,
  input b,
  input sel,
  output [0:0] out
);

  assign out = (sel == 0) ? a : b;

endmodule
