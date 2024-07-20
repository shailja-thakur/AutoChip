module top_module(
	input a, 
	input b,
	output out
);

	// Intermediate signal for OR gate output
	wire or_out;

	// OR gate operation
	assign or_out = a | b;

	// NOT gate operation (inversion)
	assign out = ~or_out;

endmodule
