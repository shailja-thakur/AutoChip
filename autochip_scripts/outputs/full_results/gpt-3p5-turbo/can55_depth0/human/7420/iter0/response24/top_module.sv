module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);
  
  wire [7:0] p1nandout = ~(p1[0] & p1[1] & p1[2] & p1[3]);
  wire [7:0] p2nandout = ~(p2[0] & p2[1] & p2[2] & p2[3]);

  assign p1y = p1nandout[0] & p1nandout[1] & p1nandout[2] & p1nandout[3];
  assign p2y = p2nandout[4] & p2nandout[5] & p2nandout[6] & p2nandout[7];

endmodule
