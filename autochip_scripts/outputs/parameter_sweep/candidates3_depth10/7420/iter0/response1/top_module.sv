module top_module(
	input [7:0] p1a,
	input [7:0] p1b,
	input [7:0] p1c,
	input [7:0] p1d,
	output [7:0] p1y,
	input [7:0] p2a,
	input [7:0] p2b,
	input [7:0] p2c,
	input [7:0] p2d,
	output [7:0] p2y
);
  
  assign p1y = ~(p1a & p1b & p1c & p1d);
  assign p2y = ~(p2a & p2b & p2c & p2d);
  
endmodule
