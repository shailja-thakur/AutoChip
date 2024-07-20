module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);
  wire w1, w2, w3, w4;

  assign w1 = a & b;
  assign w2 = c & d;
  assign w3 = w1 | w2;
  assign w4 = ~(w1 & w2);
  assign q = w3 & w4;
endmodule
