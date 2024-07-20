module top_module(
  input a, 
  input b,
  input c,
  output out
);

  // Intermediate signals
  wire w1, w2, w3;

  // Assign intermediate signals
  assign w1 = ~a & ~b & c;
  assign w2 = a & ~b & c;
  assign w3 = a & b & c;

  // Output assignment
  assign out = w1 | w2 | w3;

endmodule
