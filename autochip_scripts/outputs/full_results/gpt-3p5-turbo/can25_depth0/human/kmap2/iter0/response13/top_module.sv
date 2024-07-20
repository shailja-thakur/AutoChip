module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);
  wire w1, w2, w3, w4, w5;

  assign w1 = a & b;
  assign w2 = ~c & d;
  assign w3 = a & ~c & ~d;
  assign w4 = c & ~d;
  assign w5 = w1 | w2 | w3 | w4;

  assign out = w5;
endmodule
