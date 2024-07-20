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

  wire p1_and1;
  wire p1_and2;
  
  and gate_p1_and1(p1_and1, p1a, p1b, p1c);
  and gate_p1_and2(p1_and2, p1d, p1e, p1f);
  
  or gate_p1y(p1y, p1_and1, p1_and2);
  
  wire p2_and1;
  wire p2_and2;
  
  and gate_p2_and1(p2_and1, p2a, p2b);
  and gate_p2_and2(p2_and2, p2c, p2d);
  
  or gate_p2y(p2y, p2_and1, p2_and2);
  
endmodule
module and (
  output o,
  input i1,
  input i2,
  input i3
);
  assign o = i1 & i2 & i3;
endmodule
module or (
  output o,
  input i1,
  input i2
);
  assign o = i1 | i2;
endmodule
