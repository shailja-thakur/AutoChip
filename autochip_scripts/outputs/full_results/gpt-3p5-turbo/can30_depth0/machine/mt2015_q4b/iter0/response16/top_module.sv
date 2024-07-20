module top_module(
  input x,
  input y,
  output z);

  // Logic for z output
  assign z = ~(x ^ y);

endmodule
