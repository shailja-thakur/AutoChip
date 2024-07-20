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
	
	// Declare internal signals
	wire n1, n2;
	
	// Implement the two 4-input NAND gates
	assign n1 = ~(p1a & p1b & p1c & p1d);
	assign n2 = ~(p2a & p2b & p2c & p2d);
	
	// Assign outputs
	assign p1y = n1;
	assign p2y = n2;
	
endmodule
