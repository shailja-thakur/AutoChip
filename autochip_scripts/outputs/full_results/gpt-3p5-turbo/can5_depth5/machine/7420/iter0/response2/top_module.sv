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
	// Instantiate the AND gates for p1y and p2y
	and #(.N(4)) and_p1(.i(p1a), .i(p1b), .i(p1c), .i(p1d), .o(p1_y));
	and #(.N(4)) and_p2(.i(p2a), .i(p2b), .i(p2c), .i(p2d), .o(p2_y));
	
	// Create the inverted outputs for p1y and p2y
	not p1_y_inv(.a(p1_y), .z(p1y));
	not p2_y_inv(.a(p2_y), .z(p2y));
	
endmodule
