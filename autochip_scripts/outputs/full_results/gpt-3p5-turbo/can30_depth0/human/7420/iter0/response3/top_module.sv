module top_module(
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

  // Declare internal wires
  wire nand1_out;
  wire nand2_out;

  // Instantiate the 4-input NAND gates
  nand_gate_4to1 nand1(
    .p1a(p1a),
    .p1b(p1b),
    .p1c(p1c),
    .p1d(p1d),
    .p1y(nand1_out)
  );

  nand_gate_4to1 nand2(
    .p1a(p2a),
    .p1b(p2b),
    .p1c(p2c),
    .p1d(p2d),
    .p1y(nand2_out)
  );

  // Output connections
  assign p1y = nand1_out;
  assign p2y = nand2_out;

endmodule
module nand_gate_4to1(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  output p1y
);
  assign p1y = ~(p1a & p1b & p1c & p1d);
endmodule
