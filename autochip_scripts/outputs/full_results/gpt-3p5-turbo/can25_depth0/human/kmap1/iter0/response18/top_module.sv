module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Define the intermediate signals
	wire w1, w2, w3;

	// Implement the Karnaugh map logic
	assign w1 = (a & ~b) | (c & ~b) | (a & b & c);
	assign w2 = (~a & b & ~c) | (~a & ~b & c);
	assign w3 = w1 | w2;

	// Output the result
	assign out = w3;

endmodule
