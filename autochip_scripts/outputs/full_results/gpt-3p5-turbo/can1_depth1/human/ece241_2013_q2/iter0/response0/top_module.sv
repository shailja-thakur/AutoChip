module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
  wire[out_sop] sop;
  wire[out_pos] pos;

  assign sop = (a & b & c & ~d) | (a & ~b & ~c & ~d) | (~a & ~b & ~c & ~d);
  assign pos = (a | ~b | ~c | d) & (a | b | ~c | d) & (a | ~b | c | d);

  assign out_sop = sop;
  assign out_pos = pos;

endmodule
