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

	// Internal wire declarations
	wire w1, w2, w3, w4, w5, w6, w7, w8;

	// 4-input NAND gate 1
	nand u1(
		.a(p1a),
		.b(p1b),
		.c(p1c),
		.d(p1d),
		.y(w1)
	);

	// 4-input NAND gate 2
	nand u2(
		.a(p2a),
		.b(p2b),
		.c(p2c),
		.d(p2d),
		.y(w2)
	);

	// Internal wire declarations
	wire w9, w10;

	// 2-input NAND gate 1
	nand u3(
		.a(w1),
		.b(w1),
		.y(w9)
	);

	// 2-input NAND gate 2
	nand u4(
		.a(w1),
		.b(w1),
		.y(w10)
	);

	// Output assignments
	assign p1y = w9;
	assign p2y = w10;

endmodule
