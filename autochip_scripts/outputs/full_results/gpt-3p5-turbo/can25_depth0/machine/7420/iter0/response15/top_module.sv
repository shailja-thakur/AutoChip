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
	// Declare internal wires for intermediate signals
	wire and1_out, and2_out;
	
	// AND gate for p1y
	and and1(and1_out, p1a, p1b, p1c, p1d);
	
	// AND gate for p2y
	and and2(and2_out, p2a, p2b, p2c, p2d);
	
	// Inverter for p1y
	not inv1(p1y, and1_out);
	
	// Inverter for p2y
	not inv2(p2y, and2_out);
	
endmodule
