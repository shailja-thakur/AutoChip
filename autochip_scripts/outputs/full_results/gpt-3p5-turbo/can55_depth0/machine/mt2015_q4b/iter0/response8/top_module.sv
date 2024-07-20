module top_module(
  input x,
  input y,
  output z);

  // XOR gate
  wire xor_result;
  assign xor_result = x ^ y;

  // NOT gate
  wire not_result;
  assign not_result = ~xor_result;

  // Output
  assign z = not_result;

endmodule
