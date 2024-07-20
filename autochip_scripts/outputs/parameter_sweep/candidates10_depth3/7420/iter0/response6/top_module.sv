module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire p1_out, p2_out;

  assign p1_out = p1[0] & p1[1] & p1[2] & p1[3];
  assign p2_out = p2[0] & p2[1] & p2[2] & p2[3];
  
  assign p1y = ~p1_out;
  assign p2y = ~p2_out;

endmodule
