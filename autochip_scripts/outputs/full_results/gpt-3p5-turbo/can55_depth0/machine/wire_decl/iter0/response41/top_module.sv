module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n );

  wire w1, w2;

  and gate_and1(w1, a, b);
  and gate_and2(w2, c, d);
  or gate_or(out, w1, w2);
  not gate_not(out_n, out);

endmodule
