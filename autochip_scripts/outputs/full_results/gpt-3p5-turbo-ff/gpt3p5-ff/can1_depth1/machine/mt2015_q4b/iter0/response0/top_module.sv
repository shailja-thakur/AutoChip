module top_module(
  input x,
  input y,
  output z);

  // XOR gate
  wire xy_xor;
  assign xy_xor = x ^ y;

  // NOT gate
  wire z_not;
  assign z_not = ~xy_xor;

  // Output
  assign z = z_not;

endmodule
