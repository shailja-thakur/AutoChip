module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Use three input AND gates and one OR gate to implement the truth table
	
	assign f = (x2 & ~x1) | (x3 & ~x2 & x1);

endmodule
