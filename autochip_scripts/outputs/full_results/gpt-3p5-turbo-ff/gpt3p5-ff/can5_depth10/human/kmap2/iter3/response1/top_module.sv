module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);

  // Intermediate wires
  wire w1, w2, w3, w4, w5;

  // Implementing logic gates
  assign w1 = ~(a & b);
  assign w2 = ~(~c & d);
  assign w3 = a & b;
  assign w4 = ~c & ~d;
  assign w5 = w1 | w2;
  
  // Fixing the final output
  assign out = ~(w3 | w4 | w5);

endmodule
