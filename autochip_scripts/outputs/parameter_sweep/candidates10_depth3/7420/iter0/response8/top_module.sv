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
	wire nand1_out, nand2_out;
	
	// Instantiate NAND gates
	nand nand1(p1a, p1b, p1c, p1d, nand1_out);
	nand nand2(p2a, p2b, p2c, p2d, nand2_out);
	
	// Assign outputs
	assign p1y = nand1_out;
	assign p2y = nand2_out;
	
endmodule
module nand(
	input a,
	input b,
	input c,
	input d,
	output out
);
	// Internal wires
	wire nand1_out, nand2_out;
	
	// Instantiate NAND gate
	assign nand1_out = ~(a & b & c & d);
	assign out = ~(nand1_out & nand2_out);
	
endmodule
