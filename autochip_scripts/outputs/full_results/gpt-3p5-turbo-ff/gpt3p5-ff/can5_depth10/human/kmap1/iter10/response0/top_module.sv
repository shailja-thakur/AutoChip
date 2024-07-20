module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Define internal wire signals
	wire w1, w2, w3, w4;
	
	// Define the truth table
	assign w1 = ~(a & b & c);
	assign w2 = a & b;
	assign w3 = b & c;
	assign w4 = w2 | w3;
	
	// Assign the output
	assign out = w1 | w4;

endmodule
