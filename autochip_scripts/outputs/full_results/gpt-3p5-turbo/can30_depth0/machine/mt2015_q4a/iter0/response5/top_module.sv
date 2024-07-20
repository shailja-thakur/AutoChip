module top_module(
	input x,
	input y,
	output z);

	// XOR gate for x and y
	wire xor_output;
	xor xor_gate(.a(x), .b(y), .x(xor_output));

	// AND gate for xor_output and x
	and and_gate(.a(xor_output), .b(x), .z(z));

endmodule
