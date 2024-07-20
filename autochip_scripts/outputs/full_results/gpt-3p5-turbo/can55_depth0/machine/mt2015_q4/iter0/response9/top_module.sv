module top_module(
	input x,
	input y,
	output z
);

wire a, b;
and gate1(a, y, b); // gate1 output is a
and gate2(x, b, a); // gate2 output is b
xor gate3(a, b, z); // gate3 output is z

endmodule
