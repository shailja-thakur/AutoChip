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

	// Internal wires
	wire w1, w2, w3, w4;

	// 4-input NAND gates
	nand4 u1(
		.a(p1a), 
		.b(p1b), 
		.c(p1c), 
		.d(p1d), 
		.y(w1)
	);

	nand4 u2(
		.a(p2a), 
		.b(p2b), 
		.c(p2c), 
		.d(p2d), 
		.y(w2)
	);

	// Additional logic
	and2 u3(
		.a(w1), 
		.b(w2), 
		.y(w3)
	);

	not1 u4(
		.a(w2), 
		.y(w4)
	);

	// Output connections
	assign p1y = w4;
	assign p2y = w3;

endmodule
