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

  // Internal wires for intermediate signals
  wire nand1_output;
  wire nand2_output;

  // Instantiate NAND gates
  nand_gate nand1 (.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_output));
  nand_gate nand2 (.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_output));

  // Output assignments
  assign p1y = nand1_output;
  assign p2y = nand2_output;

endmodule
module nand_gate (
  input a,
  input b,
  input c,
  input d,
  output y
);
  // NAND gate using 4 inputs
  assign y = ~(a & b & c & d);
endmodule
