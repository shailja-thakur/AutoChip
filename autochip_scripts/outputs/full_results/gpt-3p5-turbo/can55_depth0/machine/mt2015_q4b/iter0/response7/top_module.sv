module top_module(
  input x,
  input y,
  output z);

  // XOR gate
  wire xor_output;
  assign xor_output = x ^ y;

  // NOT gate
  wire not_output;
  assign not_output = ~xor_output;

  // Output
  assign z = not_output;

endmodule
