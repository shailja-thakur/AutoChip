module top_module(
  input x,
  input y,
  output z);

  // Implementing the logical XOR operation between inputs x and y
  wire xor_output;
  xor xor_gate(x, y, xor_output);

  // Implementing the logical AND operation between the XOR output and input x
  assign z = xor_output & x;

endmodule
