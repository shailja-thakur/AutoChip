module top_module(
	input x,
	input y,
	output z);

	// Gate 1
	wire a1;
	gate1 g1(
		.a(x),
		.b(y),
		.z(a1)
	);
	
	// Gate 2
	wire b1;
	gate2 g2(
		.a(y),
		.b(x),
		.z(b1)
	);
	
	// Gate 3
	gate3 g3(
		.a(a1),
		.b(b1),
		.z(z)
	);

endmodule
