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
	// Implementing the logic for p1y
	and and_gate1(p1a, p1b, p1c, p1d, p1y);
	not not_gate1(p1y, p1y_inv);
	
	// Implementing the logic for p2y
	and and_gate2(p2a, p2b, p2c, p2d, p2y);
	not not_gate2(p2y, p2y_inv);
	
	// Connecting the inverted outputs to the outputs
	assign p1y = p1y_inv;
	assign p2y = p2y_inv;

endmodule
module and(
	input a, 
	input b, 
	input c, 
	input d, 
	output y
);
	and u1(a, b, c, d, y);
endmodule
module not(
	input a, 
	output y
);
	not u1(a, y);
endmodule
