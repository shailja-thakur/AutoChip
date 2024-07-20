module top_module(
	input x,
	input y,
	output z);

	// intermediate wire for storing x^y
	wire xor_result;

	// xor gate for x and y
	xor gate_xor(x, y, xor_result);

	// and gate for xor_result and x
	and gate_and(xor_result, x, z);

endmodule
