module top_module(
  input x,
  input y,
  output z
);

  // Logic to compute z = (x^y) & x
  assign z = (x ^ y) & x;

endmodule
