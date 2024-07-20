module top_module(
	input x,
	input y,
	output z);

	// Declare and assign intermediate variables
	wire w1, w2;

	// Logic gates for intermediate variables
	and gate1(w1, x, y);
	and gate2(w2, w1, y);

	// Output assignment
	assign z = w2;
endmodule
