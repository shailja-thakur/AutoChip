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

  wire p1y_temp;
  wire p2y_temp;

  and gate_p1(p1a, p1b, p1c, p1d, p1y_temp);
  and gate_p2(p2a, p2b, p2c, p2d, p2y_temp);

  not inv_p1(p1y_temp, p1y);
  not inv_p2(p2y_temp, p2y);
  
endmodule
