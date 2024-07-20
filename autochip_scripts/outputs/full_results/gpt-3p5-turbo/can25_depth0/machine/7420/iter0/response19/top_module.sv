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

// Declare intermediate wire variables
wire p1_and_out;
wire p2_and_out;

// Implement AND gates
and and_gate1(p1_and_out, p1a, p1b, p1c, p1d);
and and_gate2(p2_and_out, p2a, p2b, p2c, p2d);

// Implement inverters
not inv1(p1y, p1_and_out);
not inv2(p2y, p2_and_out);

endmodule
