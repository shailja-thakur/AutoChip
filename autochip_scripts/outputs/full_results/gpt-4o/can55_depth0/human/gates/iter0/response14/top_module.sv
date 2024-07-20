module top_module (
	input wire a,
	input wire b,
	output wire out_and,
	output wire out_or,
	output wire out_xor,
	output wire out_nand,
	output wire out_nor,
	output wire out_xnor,
	output wire out_anotb
);

	assign out_and = a & b;        // AND gate
	assign out_or = a | b;         // OR gate
	assign out_xor = a ^ b;        // XOR gate
	assign out_nand = ~(a & b);    // NAND gate
	assign out_nor = ~(a | b);     // NOR gate
	assign out_xnor = a ~^ b;      // XNOR gate
	assign out_anotb = a & ~b;     // A AND NOT B

endmodule
