module top_module(
	input [3:0] p1a, 
	input [3:0] p1b, 
	input [3:0] p1c, 
	input [3:0] p1d, 
	output p1y, 
	input [3:0] p2a, 
	input [3:0] p2b, 
	input [3:0] p2c, 
	input [3:0] p2d, 
	output p2y
);

wire [3:0] p1i, p2i;
assign p1i = ~(&{p1a, p1b, p1c, p1d});
assign p2i = ~(&{p2a, p2b, p2c, p2d});

assign p1y = ~(&{p1i, p1i});
assign p2y = ~(&{p2i, p2i});

endmodule
