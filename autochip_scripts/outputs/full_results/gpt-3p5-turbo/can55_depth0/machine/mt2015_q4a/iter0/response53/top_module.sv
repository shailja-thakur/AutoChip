module top_module(
  input x,
  input y,
  output z);

  // XOR of inputs x and y
  wire xor_out;
  assign xor_out = x ^ y;

  // AND operation between xor_out and input x
  assign z = xor_out & x;

endmodule
