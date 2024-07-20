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
  
  // Internal signals
  wire p1_nand_out;
  wire p2_nand_out;
  
  // First NAND gate
  nand_gate p1_nand (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(p1_nand_out)
  );
  
  // Second NAND gate
  nand_gate p2_nand (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(p2_nand_out)
  );
  
  // Output assignments
  assign p1y = p1_nand_out;
  assign p2y = p2_nand_out;

endmodule
module nand_gate (
  input a,
  input b,
  input c,
  input d,
  output y
);
  
  // Internal signal
  wire first_nand_out;
  
  // First NAND gate
  nand gate_first (
    .a(a),
    .b(b),
    .y(first_nand_out)
  );
  
  // Second NAND gate
  nand gate_second (
    .a(first_nand_out),
    .b(c),
    .y(y)
  );

endmodule
module nand (
  input a,
  input b,
  output y
);
  
  // Implementation of NAND gate
  assign y = ~(a & b);

endmodule
