module top_module(
  input a,
  input b,
  output out
);

  // implementation of the XOR gate
  wire xor_gate;
  assign xor_gate = a ^ b;

  // implementation of the output
  assign out = ~xor_gate;

endmodule
