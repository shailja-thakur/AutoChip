module top_module (
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);

  // Internal wires
  wire nand1_out;
  wire nand2_out;

  // First 4-input NAND gate
  nand nand1 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(nand1_out)
  );

  // Second 4-input NAND gate
  nand nand2 (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(nand2_out)
  );

  // Outputs
  assign p1y = nand1_out;
  assign p2y = nand2_out;

endmodule
