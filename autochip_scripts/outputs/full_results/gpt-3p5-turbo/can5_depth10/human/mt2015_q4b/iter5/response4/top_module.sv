module top_module(
  input x,
  input y,
  output z);

  assign #5 z = x & y;

endmodule
