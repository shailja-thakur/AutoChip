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

  wire p1_and1_out;
  wire p1_and2_out;
  wire p2_and1_out;
  wire p2_and2_out;

  assign p1y = p1_and1_out | p1_and2_out;
  assign p2y = p2_and1_out | p2_and2_out;

  and p1_and1(p1_and1_out, p1a, p1b, p1c);
  and p1_and2(p1_and2_out, p1d, p1e, p1f);
  and p2_and1(p2_and1_out, p2a, p2b);
  and p2_and2(p2_and2_out, p2c, p2d);

endmodule
