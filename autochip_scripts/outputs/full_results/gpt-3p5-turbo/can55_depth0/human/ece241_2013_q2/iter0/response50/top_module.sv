module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  wire out_2;
  wire out_7;
  wire out_15;

  wire out_0;
  wire out_1;
  wire out_4;
  wire out_5;
  wire out_6;
  wire out_9;
  wire out_10;
  wire out_13;
  wire out_14;

  and(out_2, ~a, ~b, ~c, d);
  and(out_7, ~a, b, c, d);
  and(out_15, a, b, c, d);

  and(out_0, ~a, ~b, ~c, ~d);
  and(out_1, ~a, ~b, c, ~d);
  and(out_4, ~a, b, ~c, ~d);
  and(out_5, ~a, b, c, ~d);
  and(out_6, a, ~b, ~c, ~d);
  and(out_9, a, ~b, c, ~d);
  and(out_10, a, b, ~c, ~d);
  and(out_13, a, ~b, ~c, d);
  and(out_14, a, b, ~c, d);

  or(out_sop, out_2, out_7, out_15);
  or(out_pos, out_0, out_1, out_4, out_5, out_6, out_9, out_10, out_13, out_14);

endmodule
