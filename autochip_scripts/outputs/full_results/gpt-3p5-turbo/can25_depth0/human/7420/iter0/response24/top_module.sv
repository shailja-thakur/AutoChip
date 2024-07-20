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
	// Define internal signals
	wire nand1_output;
	wire nand2_output;

	// Define NAND gates
	assign nand1_output = ~(p1a & p1b & p1c & p1d);
	assign nand2_output = ~(p2a & p2b & p2c & p2d);

	// Define outputs
	assign p1y = nand1_output;
	assign p2y = nand2_output;
endmodule
