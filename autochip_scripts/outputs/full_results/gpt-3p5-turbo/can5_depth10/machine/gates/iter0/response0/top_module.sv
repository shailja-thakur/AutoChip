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

	/* perform logical AND operation */
	assign out_and = a & b;

	/* perform logical OR operation */
	assign out_or = a | b;

	/* perform logical XOR operation */
	assign out_xor = a ^ b;

	/* perform logical NAND operation */
	assign out_nand = ~(a & b);

	/* perform logical NOR operation */
	assign out_nor = ~(a | b);

	/* perform logical XNOR operation */
	assign out_xnor = ~(a ^ b);

	/* perform logical AND NOT operation */
	assign out_anotb = a & (~b);

endmodule
