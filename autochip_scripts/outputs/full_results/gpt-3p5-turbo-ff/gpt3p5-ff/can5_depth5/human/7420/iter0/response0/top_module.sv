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
	
	// Define internal wires
	wire n1, n2, n3, n4, n5, n6, n7, n8;
	
	// Instantiate two 4-input NAND gates
	nand4_gate n1_gate(p1a, p1b, p1c, p1d, n1);
	nand4_gate n2_gate(p2a, p2b, p2c, p2d, n2);
	
	// Wire the outputs to the internal wires
	assign p1y = n1;
	assign p2y = n2;

	// Define the NAND4 gate module
	module nand4_gate(
		input a,
		input b,
		input c,
		input d,
		output out
	);
		wire nand1_out, nand2_out, nand3_out, nand4_out;
		
		nand_gate nand1(a, b, nand1_out);
		nand_gate nand2(c, d, nand2_out);
		nand_gate nand3(nand1_out, nand2_out, nand3_out);
		nand_gate nand4(nand3_out, nand3_out, out);
		
		module nand_gate(
			input a,
			input b,
			output out
		);
			assign out = ~(a & b);
		endmodule
