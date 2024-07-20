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

	// (1) out_and: a and b
	assign out_and = a & b;
	
	// (2) out_or: a or b
	assign out_or = a | b;
	
	// (3) out_xor: a xor b
	assign out_xor = a ^ b;
	
	// (4) out_nand: a nand b
	assign out_nand = ~(a & b);
	
	// (5) out_nor: a nor b
	assign out_nor = ~(a | b);
	
	// (6) out_xnor: a xnor b
	assign out_xnor = ~(a ^ b);
	
	// (7) out_anotb: a and-not b
	assign out_anotb = a & (~b);

endmodule
