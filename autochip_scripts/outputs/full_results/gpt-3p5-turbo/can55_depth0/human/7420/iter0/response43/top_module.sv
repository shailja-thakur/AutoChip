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

  wire p1nand, p2nand;

  // Implementing the 4-input NAND gate for p1y
  and #(4) and_gate1 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .out(p1nand)
  );

  not not_gate1 (
    .a(p1nand),
    .out(p2y)
  );

  // Implementing the 4-input NAND gate for p2y
  and #(4) and_gate2 (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .out(p2nand)
  );

  not not_gate2 (
    .a(p2nand),
    .out(p2y)
  );

endmodule
