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
	wire nand1_out;
	wire nand2_out;

	// Gate-level implementation of the 7420 chip
	assign nand1_out = ~(p1a & p1b & p1c & p1d);
	assign nand2_out = ~(p2a & p2b & p2c & p2d);
	assign p1y = nand1_out;
	assign p2y = nand2_out;
	
endmodule
