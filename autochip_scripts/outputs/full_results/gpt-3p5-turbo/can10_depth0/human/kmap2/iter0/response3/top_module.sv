module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Create wire connections for the Karnaugh map
	wire w1, w2, w3, w4;

	// Implement the boolean logic for the Karnaugh map
	assign w1 = a & ~b & c & ~d;
	assign w2 = a & ~b & ~c & d;
	assign w3 = ~a & b & c & d;
	assign w4 = a & b & ~c & ~d;

	// Combine the wire outputs to get the final output
	assign out = w1 | w2 | w3 | w4;

endmodule
