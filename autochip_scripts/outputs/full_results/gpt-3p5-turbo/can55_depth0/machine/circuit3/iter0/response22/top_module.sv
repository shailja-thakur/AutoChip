module top_module(
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire ab_or;
  wire cd_or;

  or gate_ab(
    .a(a),
    .b(b),
    .q(ab_or)
  );

  or gate_cd(
    .a(c),
    .b(d),
    .q(cd_or)
  );

  and gate_q(
    .a(ab_or),
    .b(cd_or),
    .q(q)
  );

endmodule
