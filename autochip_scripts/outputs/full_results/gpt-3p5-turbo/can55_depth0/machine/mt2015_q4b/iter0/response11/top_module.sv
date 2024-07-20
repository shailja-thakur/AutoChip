module top_module(
	input x,
	input y,
	output z
);

	// XOR gate
	wire xor_output;
	xor xor_gate(.A(x), .B(y), .Z(xor_output));
	
	// Negation gate
	assign z = ~xor_output;

endmodule
