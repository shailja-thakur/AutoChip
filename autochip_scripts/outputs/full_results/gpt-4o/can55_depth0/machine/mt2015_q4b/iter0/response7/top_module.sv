module top_module(
	input x,
	input y,
	output z);

	assign z = ~(x ^ y); // Negation of XOR operation

endmodule
