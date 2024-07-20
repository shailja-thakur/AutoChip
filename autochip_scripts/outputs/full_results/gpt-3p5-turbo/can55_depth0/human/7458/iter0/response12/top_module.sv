module top_module(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p1e,
  input p1f,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);

  wire p1y_w1;
  wire p1y_w2;
  wire p2y_w1;
  wire p2y_w2;

  assign p1y = p1y_w1 | p1y_w2;
  assign p2y = p2y_w1 | p2y_w2;

  and #(3) p1y_gate1(p1y_w1, p1a, p1b, p1c);
  and #(3) p1y_gate2(p1y_w2, p1d, p1e, p1f);
  and #(2) p2y_gate1(p2y_w1, p2a, p2b);
  and #(2) p2y_gate2(p2y_w2, p2c, p2d);

endmodule
