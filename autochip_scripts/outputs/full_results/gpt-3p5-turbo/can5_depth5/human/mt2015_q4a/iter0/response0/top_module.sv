module top_module(
	input x,
	input y,
	output z);

	// 1-bit wire to hold the result of x XOR y
	wire xor_result;

	// 1-bit wire to hold the result of (x XOR y) AND x
	wire and_result;

	// XOR gate to calculate x XOR y
	xor gate_xor(x, y, xor_result);

	// AND gate to calculate (x XOR y) AND x
	and gate_and(xor_result, x, and_result);

	// Assigning the result to the output
	assign z = and_result;

endmodule
