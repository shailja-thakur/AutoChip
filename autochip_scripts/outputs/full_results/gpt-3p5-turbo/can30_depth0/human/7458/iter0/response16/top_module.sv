module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	
	// Intermediate wires for internal signals
	wire int1;
	wire int2;
	wire int3;
	wire int4;
	
	// Logic for p1y
	assign int1 = p1a & p1b & p1c;
	assign int2 = p1d & p1e & p1f;
	assign p1y = int1 | int2;
	
	// Logic for p2y
	assign int3 = p2a & p2b;
	assign int4 = p2c & p2d;
	assign p2y = int3 | int4;

endmodule
