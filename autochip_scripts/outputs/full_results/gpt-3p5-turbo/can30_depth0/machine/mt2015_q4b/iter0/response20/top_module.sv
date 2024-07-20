module top_module(
    input x,
    input y,
    output z
  );

  // Declare wire for intermediate signal
  wire intermediate;

  // Implement XOR gate
  xor gate_xor (
    .a(x),
    .b(y),
    .o(intermediate)
  );

  // Implement NOT gate
  not gate_not (
    .a(intermediate),
    .o(z)
  );

endmodule
