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

  // Internal wire declarations
  wire nand1_out;
  wire nand2_out;

  // NAND gate instances
  nand4 nand1(
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(nand1_out)
  );

  nand4 nand2(
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(nand2_out)
  );

  // Output assignments
  assign p1y = ~nand1_out;
  assign p2y = ~nand2_out;

endmodule
module nand4(
  input a,
  input b,
  input c,
  input d,
  output y
);
  wire nand1_out;
  wire nand2_out;
  wire nand3_out;

  // Internal NAND gate instances
  nand2 nand1(
    .a(a),
    .b(b),
    .y(nand1_out)
  );

  nand2 nand2(
    .a(c),
    .b(d),
    .y(nand2_out)
  );

  nand2 nand3(
    .a(nand1_out),
    .b(nand2_out),
    .y(nand3_out)
  );

  // Output assignment
  assign y = ~nand3_out;

endmodule
module nand2(
  input a,
  input b,
  output y
);
  nand nand1(
    .a(a),
    .b(b),
    .y(y)
  );

endmodule
module nand(
  input a,
  input b,
  output y
);
  assign y = ~(a & b);

endmodule
