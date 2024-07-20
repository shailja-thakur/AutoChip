module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);

  wire w1, w2, w3, w4;

  and #(4) G1(w1, ~a, ~b, c, ~d);
  or #(4) G2(w2, ~a, b, c, ~d);
  or #(4) G3(w3, a, ~b, c, d);
  or #(4) G4(w4, a, b, ~c, ~d);
  or #(4) G5(out, w1, w2, w3, w4);
  
endmodule
