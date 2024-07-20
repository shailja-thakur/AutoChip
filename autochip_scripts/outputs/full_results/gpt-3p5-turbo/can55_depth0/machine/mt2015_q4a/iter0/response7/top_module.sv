module top_module(
  input x,
  input y,
  output z);

  /* XOR gate */
  wire xor_output;
  xor gate_x1 (
    .a(x),
    .b(y),
    .z(xor_output)
  );

  /* AND gate */
  and gate_a1 (
    .a(x),
    .b(xor_output),
    .z(z)
  );

endmodule
