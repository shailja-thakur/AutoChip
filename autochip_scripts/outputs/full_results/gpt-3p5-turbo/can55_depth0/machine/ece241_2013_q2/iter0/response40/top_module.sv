module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  wire pos0, pos1;

  // out_sop = SOP expression
  assign out_sop = (c & d) | (!a & !b & c);

  // pos0 = logical AND of inputs c, logical OR of !b & d, and the OR of !a & b
  assign pos0 = c & (!b | d) & (!a | b);

  // pos1 = logical AND of inputs c, logical OR of !a & d
  assign pos1 = c & (!a | d);

  // out_pos = ternary expression to check pos0 and pos1 equality
  assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
