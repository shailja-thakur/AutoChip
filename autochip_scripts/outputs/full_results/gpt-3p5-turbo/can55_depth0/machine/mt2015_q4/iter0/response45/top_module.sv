module top_module(
	input x,
	input y,
	output z);

	// First gate
	wire w1;
	gate1 g1(
		.a(x),
		.b(y),
		.z(w1)
	);

	// Second gate
	wire w2;
	gate2 g2(
		.a(y),
		.b(x),
		.z(w2)
	);

	// Third gate
	gate3 g3(
		.a(w1),
		.b(w2),
		.z(z)
	);

endmodule
module gate1(
	input a,
	input b,
	output z);

	// Gate 1 implementation here
	assign z = a & b;

endmodule
module gate2(
	input a,
	input b,
	output z);

	// Gate 2 implementation here
	assign z = a & b;

endmodule
module gate3(
	input a,
	input b,
	output z);

	// Gate 3 implementation here
	assign z = a | b;

endmodule
