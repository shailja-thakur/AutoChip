module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
  
  assign Y2 = (y[5] & ~w) | (y[1] & ~y[2]);
  assign Y4 = (y[2] & ~y[3]) | (y[3] & ~w) | (y[4] & ~y[5]);

endmodule
