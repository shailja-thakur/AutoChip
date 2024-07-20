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
	// Perform logical AND operation between a and b
	assign out_and = a & b;

	// Perform logical OR operation between a and b
	assign out_or = a | b;

	// Perform logical XOR operation between a and b
	assign out_xor = a ^ b;

	// Perform logical NAND operation between a and b
	assign out_nand = ~(a & b);

	// Perform logical NOR operation between a and b
	assign out_nor = ~(a | b);

	// Perform logical XNOR operation between a and b
	assign out_xnor = ~(a ^ b);

	// Perform logical AND NOT operation between a and b
	assign out_anotb = a & (~b);
endmodule
