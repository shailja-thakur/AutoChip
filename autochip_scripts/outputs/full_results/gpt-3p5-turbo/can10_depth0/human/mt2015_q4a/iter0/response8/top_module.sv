module top_module(
  input x,
  input y,
  output z);

  // Combinational logic implementation
  assign z = (x ^ y) & x;

endmodule
