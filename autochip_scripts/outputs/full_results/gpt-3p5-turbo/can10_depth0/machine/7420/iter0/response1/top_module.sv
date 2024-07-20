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
	// Internal signals
	wire p1and, p2and;
	
	// Logic for p1y output
	and #(.N(4)) and_p1(p1a, p1b, p1c, p1d, p1and);
	not not_p1(p1and, p1y);
	
	// Logic for p2y output
	and #(.N(4)) and_p2(p2a, p2b, p2c, p2d, p2and);
	not not_p2(p2and, p2y);
endmodule
