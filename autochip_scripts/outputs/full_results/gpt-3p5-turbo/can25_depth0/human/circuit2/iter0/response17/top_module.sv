module top_module(
  input a,
  input b,
  input c,
  input d,
  output q
);

  // Define intermediate signals
  wire w1, w2, w3, w4, w5, w6;

  // Implement the combinational circuit
  assign w1 = a & b;
  assign w2 = ~c;
  assign w3 = w1 | w2;
  assign w4 = d & w3;
  assign w5 = (a | b) & (~c);
  assign w6 = w4 ^ w5;
  assign q = ~w6;

endmodule
