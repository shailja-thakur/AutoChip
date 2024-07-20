module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

  wire q1;
  wire q2;
  wire q3;
  wire q4;

  // Gate-level implementation of the circuit
  xor (q1, a, b);
  xor (q2, q1, c);
  and (q3, q1, d);
  or (q4, q2, q3);
  assign q = q4;

endmodule
