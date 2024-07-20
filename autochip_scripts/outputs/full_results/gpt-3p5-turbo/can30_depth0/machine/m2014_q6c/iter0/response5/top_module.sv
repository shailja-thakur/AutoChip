module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
  wire y0 = y[1];
  wire y5 = y[6];
  wire y6 = y[5];
  wire y7 = y[4];
  
  assign Y2 = y0 & ~w;
  assign Y4 = y5 & y6 & y7 & w;
  
endmodule
