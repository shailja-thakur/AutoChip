module top_module(
  input x,
  input y,
  output z
);

  // XOR gate
  wire xor_output;
  xor gate_xoy(x, y, xor_output);

  // NOT gate
  assign z = ~xor_output;

  // XOR gate
  xor gate_xy(x, y, z);

endmodule
module xor(
  input x,
  input y,
  output z
);
  assign z = x ^ y;
endmodule
