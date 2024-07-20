module top_module(
	input x,
	input y,
	output z);

	// Definition of internal wire(s)
	wire xor_out;

	// XOR gate implementation
	assign xor_out = x ^ y;

	// NOT gate implementation
	assign z = ~xor_out;

endmodule
