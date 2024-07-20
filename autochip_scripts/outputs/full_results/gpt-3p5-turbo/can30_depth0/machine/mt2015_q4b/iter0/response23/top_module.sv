module top_module(
	input x,
	input y,
	output z);

	// Create internal wire to store intermediate results
	wire x_xor_y;
	
	// Compute XOR of x and y
	assign x_xor_y = x ^ y;
	
	// Compute the logical negation of XOR
	assign z = ~x_xor_y;
	
endmodule
