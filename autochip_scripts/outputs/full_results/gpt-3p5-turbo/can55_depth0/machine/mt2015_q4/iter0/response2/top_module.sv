module top_module(
	input x,
	input y,
	output z);

	// Define internal wire inputs
	wire a, b;

	// First gate
	and gate1(a, x, y);

	// Second gate
	and gate2(b, y, x);

	// Third gate
	or gate3(z, a, b);
endmodule
