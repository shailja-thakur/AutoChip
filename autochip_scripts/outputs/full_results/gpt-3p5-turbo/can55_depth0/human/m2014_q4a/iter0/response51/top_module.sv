module d_latch (
  input d,
  input ena,
  output logic q
);

  always @ (posedge ena)
    if (ena) q <= d;

endmodule
module top_module (
  input d,
  input ena,
  output logic q
);

  d_latch d_latch_inst (
    .d(d),
    .ena(ena),
    .q(q)
  );

endmodule
