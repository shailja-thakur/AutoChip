module top_module (
  input x,
  input y,
  output z
);

  // Intermediate wire for XOR operation
  wire x_xor_y;

  // Intermediate wire for negation operation
  wire not_x_xor_y;

  // XOR gate
  xor #(
    .N(2)
  ) xor_gate (
    .A(x),
    .B(y),
    .Z(x_xor_y)
  );

  // Negation gate
  not not_gate (
    .A(x_xor_y),
    .Z(not_x_xor_y)
  );

  // Output assignment
  assign z = not_x_xor_y;

endmodule
