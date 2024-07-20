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
	
	// Internal signal to store the result of the first NAND gate operation
	wire nand1_result;
	// Internal signal to store the result of the second NAND gate operation
	wire nand2_result;
	
	// Implementing the first NAND gate
	// Output of the first NAND gate will be stored in nand1_result
	nand u1_nand(
		.p(p1a), 
		.p(p1b), 
		.p(p1c),
		.p(p1d),
		.y(nand1_result)
	);
	
	// Implementing the second NAND gate
	// Output of the second NAND gate will be stored in nand2_result
	nand u2_nand(
		.p(p2a), 
		.p(p2b),
		.p(p2c), 
		.p(p2d), 
		.y(nand2_result)
	);
	
	// Assigning the output signals
	assign p1y = nand1_result;
	assign p2y = nand2_result;
	
endmodule
module nand(
	input p,
	output y
);
	
	// Implementing the NAND gate
	assign y = ~(p & p);
	
endmodule
