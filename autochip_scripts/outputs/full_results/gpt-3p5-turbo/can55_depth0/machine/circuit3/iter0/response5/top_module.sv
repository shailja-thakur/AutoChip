module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire or_ab;
  wire or_cd;

  or_gate or1 (.a(a), .b(b), .q(or_ab));
  or_gate or2 (.a(c), .b(d), .q(or_cd));

  and_gate and1 (.a(or_ab), .b(or_cd), .q(q));

endmodule
module or_gate (
  input a,
  input b,
  output q
);

  assign q = a | b;

endmodule
module and_gate (
  input a,
  input b,
  output q
);

  assign q = a & b;

endmodule
