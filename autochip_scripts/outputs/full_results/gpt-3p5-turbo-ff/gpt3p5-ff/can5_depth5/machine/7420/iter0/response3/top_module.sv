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

// Intermediate wire variables for AND gates
wire p1and;
wire p2and;

// AND gate for p1y
and gate_p1 (
  .in1(p1a),
  .in2(p1b),
  .in3(p1c),
  .in4(p1d),
  .out(p1and)
);

// AND gate for p2y
and gate_p2 (
  .in1(p2a),
  .in2(p2b),
  .in3(p2c),
  .in4(p2d),
  .out(p2and)
);

// Inverter for p1y
not inv_p1 (
  .in(p1and),
  .out(p1y)
);

// Inverter for p2y
not inv_p2 (
  .in(p2and),
  .out(p2y)
);

endmodule
