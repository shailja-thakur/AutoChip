module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

  wire w1, w2;

  // Assigning the value of the logical AND of inputs a and b to wire w1
  assign w1 = a & b;

  // Assigning the value of the logical AND of inputs c and d to wire w2
  assign w2 = c & d;

  // Assigning the value of the logical OR of wires w1 and w2 to the output out
  assign out = w1 | w2;

  // Assigning the logical NOT of the output out to the output out_n
  assign out_n = ~out;

endmodule
