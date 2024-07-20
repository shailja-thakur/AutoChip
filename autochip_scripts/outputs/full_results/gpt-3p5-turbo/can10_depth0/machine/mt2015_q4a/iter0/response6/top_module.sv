module top_module(
  input x,
  input y,
  output z);

  // XOR gate between x and y
  wire xor_output;
  assign xor_output = x ^ y;

  // AND gate between xor_output and x
  assign z = xor_output & x;

endmodule
