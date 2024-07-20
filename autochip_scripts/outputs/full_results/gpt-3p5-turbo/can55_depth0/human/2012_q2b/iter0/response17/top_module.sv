module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  assign Y1 = y[1];
  assign Y3 = y[3];
  
endmodule
