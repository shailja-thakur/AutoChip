module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Declare internal wire variables
	wire w1, w2, w3;

	// Internal connections
	assign w1 = ~a & c;
	assign w2 = b & c;
	assign w3 = w1 | w2;

	// Output assignment
	assign out = ~w3;

endmodule
