module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  wire ab_OR, cd_OR;
  wire q_AND;

  or(ab_OR, a, b);
  or(cd_OR, c, d);
  and(q_AND, ab_OR, cd_OR);

  assign q = q_AND;

endmodule
