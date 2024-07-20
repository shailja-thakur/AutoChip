module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

  assign Y1 = y[0] & w;
  assign Y3 = (|y[1:1] | y[3:2] | y[5:4]) & (~w);

endmodule
