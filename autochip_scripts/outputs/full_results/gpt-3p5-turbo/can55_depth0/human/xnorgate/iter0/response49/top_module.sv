module top_module (
  input a,
  input b,
  output out
);

  // Implementation of XNOR gate using NAND gates
  wire n1, n2, n3, n4;

  nand nand1 (.a(a), .b(b), .out(n1));
  nand nand2 (.a(a), .b(n1), .out(n2));
  nand nand3 (.a(b), .b(n1), .out(n3));
  nand nand4 (.a(n2), .b(n3), .out(n4));

  not inv1 (.in(n4), .out(out));

endmodule
