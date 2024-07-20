module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire w1, w2;

  nandgate(p1[0], p1[1], p1[2], p1[3], w1);
  nandgate(p2[0], p2[1], p2[2], p2[3], w2);

  assign p1y = w1;
  assign p2y = w2;

endmodule
module nandgate(
  input a,
  input b,
  input c,
  input d,
  output y
); 

  assign y = ~(a & b & c & d);

endmodule
