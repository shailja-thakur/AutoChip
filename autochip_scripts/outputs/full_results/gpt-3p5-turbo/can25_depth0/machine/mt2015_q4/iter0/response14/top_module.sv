module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	wire a1, b1, a2, b2, a3, b3;

	// Instantiate logic gates
	and gate1(a1, x, y);
	and gate2(b1, y, x);
	and gate3(z, a3, b3);

	// Connecting gates
	and gate4(a2, a1, 1'b0);
	and gate5(b2, b1, 1'b0);
	and gate6(a3, a2, 1'b0);
	and gate7(b3, b2, 1'b0);

endmodule
