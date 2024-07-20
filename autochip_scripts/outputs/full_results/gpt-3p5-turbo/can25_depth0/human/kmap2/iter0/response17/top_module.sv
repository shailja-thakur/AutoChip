module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);

  wire w1, w2, w3, w4, w5, w6, w7;

  nandgate n1(w1, a, c);
  nandgate n2(w2, !b, !c);
  nandgate n3(w3, !b, c);
  nandgate n4(w4, !a, !d);
  nandgate n5(w5, b, !c);
  nandgate n6(w6, a, b);
  nandgate n7(w7, w5, w6);

  orgate o1(out, w1, w2, w3);
  orgate o2(out, w4, w7);

endmodule
