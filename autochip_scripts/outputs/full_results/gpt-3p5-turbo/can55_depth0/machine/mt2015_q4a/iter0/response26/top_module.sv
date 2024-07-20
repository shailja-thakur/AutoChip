module top_module(
	input x,
	input y,
	output z);

	// intermediate signals
	wire a;
	wire b;
	wire c;
	wire d;

	// XOR gates
	xor gate1(a, x, y);
	xor gate2(b, a, x);

	// AND gates
	and gate3(c, a, b);
	and gate4(d, x, c);

	// Output
	assign z = d;

endmodule
