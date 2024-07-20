module top_module(
  input x,
  input y,
  output z
);

// Implement the boolean function z = (x^y) & x.
assign z = (x^y) & x;

endmodule
