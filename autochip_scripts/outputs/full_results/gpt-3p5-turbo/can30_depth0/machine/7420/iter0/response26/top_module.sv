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

	// Internal wire declarations 
	wire p1_and_out;
	wire p2_and_out;

	// AND gates for p1y and p2y
	and p1_and(p1y, p1a, p1b, p1c, p1d);
	and p2_and(p2y, p2a, p2b, p2c, p2d);

	// Inverter for p1y and p2y
	not p1_not(p1y_not, p1y);
	not p2_not(p2y_not, p2y);

endmodule
