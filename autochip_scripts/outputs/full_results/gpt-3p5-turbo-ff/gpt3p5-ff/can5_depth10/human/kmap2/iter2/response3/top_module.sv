module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);

  // Intermediate wires
  wire w1, w2, w3;

  // Implementing logic gates
  assign w1 = ~(~a & ~c);
  assign w2 = ~(b & ~d);
  assign w3 = ~(~a & d);

  // Fixing the final output
  assign out = ~(w1 & w2 & w3);

endmodule
