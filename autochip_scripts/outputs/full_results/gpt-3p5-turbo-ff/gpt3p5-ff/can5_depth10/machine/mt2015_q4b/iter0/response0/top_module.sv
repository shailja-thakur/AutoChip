module top_module(
	input x,
	input y,
	output z); 

	// Define internal wire for XOR operation
	wire xor_value;

	// Implement XOR gate
	assign xor_value = x ^ y;

	// Implement output gate
	assign z = ~(x & y);

endmodule
