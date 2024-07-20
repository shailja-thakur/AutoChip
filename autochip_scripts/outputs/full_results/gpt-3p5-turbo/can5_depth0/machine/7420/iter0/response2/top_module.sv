module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d,
	output p2y
); 

wire p1_and;
wire p2_and;
wire inv_p1_and;
wire inv_p2_and;

assign p1_and = p1a & p1b & p1c & p1d;
assign p2_and = p2a & p2b & p2c & p2d;

assign inv_p1_and = ~p1_and;
assign inv_p2_and = ~p2_and;

assign p1y = inv_p1_and;
assign p2y = inv_p2_and;

endmodule
