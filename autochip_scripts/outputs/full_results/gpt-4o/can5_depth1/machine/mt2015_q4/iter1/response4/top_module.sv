module top_module(
	input x,
	input y,
	output z);

	// Intermediate wires
	wire out1, out2;

	// Instantiate the first gate with x and y as inputs
	and gate1(out1, x, y);

	// Instantiate the second gate with y and x as inputs
	or gate2(out2, y, x);

	// Instantiate the third gate with the outputs of the first and second gates as inputs
	// This time use AND gate instead of NAND gate
	and gate3(z, out1, out2);

endmodule
