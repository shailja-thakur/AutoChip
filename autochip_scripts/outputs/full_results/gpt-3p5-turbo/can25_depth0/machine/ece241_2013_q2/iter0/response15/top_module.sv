module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  wire not_a, not_b, not_c, not_d;
  wire sop, pos0, pos1;

  // NOT gate connections
  assign not_a = ~a;
  assign not_b = ~b;
  assign not_c = ~c;
  assign not_d = ~d;

  // SOP expression
  assign sop = (c & d) | (not_a & not_b & c);

  // POS expression
  assign pos0 = c & (not_b | d) | (not_a & b);
  assign pos1 = c & (not_a | d);

  // out_pos assignment
  assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

  // Output assignments
  assign out_sop = sop;

endmodule
