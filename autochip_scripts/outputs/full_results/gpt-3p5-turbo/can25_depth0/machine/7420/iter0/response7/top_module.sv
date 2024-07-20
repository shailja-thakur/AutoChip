module top_module(
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y
);
  
  wire p1_and_out;
  wire p2_and_out;
  
  assign p1_and_out = ~(p1a & p1b & p1c & p1d);
  assign p2_and_out = ~(p2a & p2b & p2c & p2d);
  
  assign p1y = p1_and_out;
  assign p2y = p2_and_out;
  
endmodule
