module mux_2to1 (
  input a,
  input b,
  input sel,
  output out
);

  assign out = sel ? b : a;

endmodule
module top_module (
  input a,
  input b,
  input sel,
  output out
);

  mux_2to1 u1 (
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
  );

endmodule
