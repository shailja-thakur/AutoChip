module top_module(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);

  wire p1_and_result;
  wire p2_and_result;

  and #(4) and_p1 (
    .a({p1a, p1b, p1c, p1d}),
    .z(p1_and_result)
  );

  and #(4) and_p2 (
    .a({p2a, p2b, p2c, p2d}),
    .z(p2_and_result)
  );

  assign p1y = ~p1_and_result;
  assign p2y = ~p2_and_result;

endmodule
