module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // SOP expression for out_sop
  wire sop1;
  assign sop1 = c & d;
  wire sop2;
  assign sop2 = ~a & ~b & c;
  assign out_sop = sop1 | sop2;

  // POS expression for out_pos
  wire pos0;
  assign pos0 = c & (~b | d) & (~a | b);
  wire pos1;
  assign pos1 = c & (~a | d);
  assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
