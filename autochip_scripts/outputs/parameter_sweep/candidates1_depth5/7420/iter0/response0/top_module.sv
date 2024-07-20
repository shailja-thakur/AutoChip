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
	wire nand1_out, nand2_out;
	
	// 4-input NAND gate 1
	assign nand1_out = ~(p1a & p1b & p1c & p1d);
	
	// 4-input NAND gate 2
	assign nand2_out = ~(p2a & p2b & p2c & p2d);
	
	// Output connections
	assign p1y = nand1_out;
	assign p2y = nand2_out;
	
endmodule
