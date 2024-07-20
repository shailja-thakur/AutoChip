module top_module(
  input a, 
  input b,
  input c,
  output out
);

  wire w1, w2;

  // Implement the circuit described by the Karnaugh map
  assign w1 = (~a & ~b & c) | (a & b & c);
  assign w2 = (~a & ~b & ~c) | (a & ~b & c) | (a & b & ~c);

  // Assign the output
  assign out = w1 | w2;

endmodule
