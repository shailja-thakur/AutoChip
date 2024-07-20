module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  wire pos0, pos1;

  // Logic for out_sop
  assign out_sop = ((~a & ~b & c) | (c & d));

  // Logic for pos0 and pos1
  assign pos0 = (c & (~b | d) | (~a & b));
  assign pos1 = (c & (~a | d));

  // Logic for out_pos
  assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
