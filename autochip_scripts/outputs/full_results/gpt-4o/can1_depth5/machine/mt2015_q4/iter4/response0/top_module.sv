module top_module(
	input x,
	input y,
	output z);

	wire out1, out2;

	// First logic gate: AND gate between x and y
	and g1(out1, x, y);

	// Second logic gate: OR gate between y and x
	or g2(out2, y, x);

	// Third logic gate: AND gate between out1 and out2
	and g3(z, out1, out2);

endmodule
