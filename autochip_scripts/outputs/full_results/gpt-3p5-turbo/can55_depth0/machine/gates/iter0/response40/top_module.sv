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

	// AND operation
	assign out_and = a & b;

	// OR operation
	assign out_or = a | b;

	// XOR operation
	assign out_xor = a ^ b;

	// NAND operation
	assign out_nand = ~(a & b);

	// NOR operation
	assign out_nor = ~(a | b);

	// XNOR operation
	assign out_xnor = ~(a ^ b);

	// AND NOT operation
	assign out_anotb = a & (~b);

endmodule
