module top_module (
	input a,
	input b,
	output out_and,
	output out_or,
	output out_xor,
	output out_nand,
	output out_nor,
	output out_xnor,
	output out_anotb
);

	// Output for AND gate
	assign out_and = a & b;
	
	// Output for OR gate
	assign out_or = a | b;
	
	// Output for XOR gate
	assign out_xor = a ^ b;
	
	// Output for NAND gate
	assign out_nand = ~(a & b);
	
	// Output for NOR gate
	assign out_nor = ~(a | b);
	
	// Output for XNOR gate
	assign out_xnor = ~(a ^ b);
	
	// Output for ANOTB gate
	assign out_anotb = a & ~b;

endmodule
