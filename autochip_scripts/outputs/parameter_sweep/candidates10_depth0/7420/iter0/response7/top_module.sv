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
	wire nand1, nand2;
	
	// NAND gate 1
	nand #(4) nand_gate1(
		.in1(p1a), 
		.in2(p1b), 
		.in3(p1c), 
		.in4(p1d), 
		.out(nand1)
	);
	
	// NAND gate 2
	nand #(4) nand_gate2(
		.in1(p2a), 
		.in2(p2b), 
		.in3(p2c), 
		.in4(p2d), 
		.out(nand2)
	);
	
	// Assign output signals
	assign p1y = nand1;
	assign p2y = nand2;
	
endmodule
