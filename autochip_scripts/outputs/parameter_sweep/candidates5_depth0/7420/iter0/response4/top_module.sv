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

	// NAND gates
	wire nand1_out, nand2_out;

	// First NAND gate
	assign nand1_out = ~(p1a & p1b & p1c & p1d);

	// Second NAND gate
	assign nand2_out = ~(p2a & p2b & p2c & p2d);

	// Output assignments
	assign p1y = nand1_out;
	assign p2y = nand2_out;

endmodule
