module top_module (
  input [6:1] y,
  input w,
  output reg Y2,
  output reg Y4
);

// Assigning Y2
assign Y2 = y[1] & (~w);

// Assigning Y4
assign Y4 = y[6:5] & y[3:2] & w;

endmodule
