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

	// Define the 4-input NAND gates
	nand #4 p1_nand1(nand1_out, p1a, p1b, p1c, p1d);
	nand #4 p2_nand2(nand2_out, p2a, p2b, p2c, p2d);

	// Output connections
	assign p1y = nand1_out;
	assign p2y = nand2_out;

endmodule
module nand(
	output nand_out,
	input in1,
	input in2,
	input in3,
	input in4
);

	assign nand_out = ~(in1 & in2 & in3 & in4);

endmodule
