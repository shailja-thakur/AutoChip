module top_module(
	input x,
	input y,
	output z);

	// Internal wire to store the intermediate result of (x^y)
	wire xy;

	// XOR gate to compute (x^y)
	xor_gate xor1(.a(x), .b(y), .y(xy));

	// AND gate to compute ((x^y) & x)
	and_gate and1(.a(xy), .b(x), .y(z));

endmodule
