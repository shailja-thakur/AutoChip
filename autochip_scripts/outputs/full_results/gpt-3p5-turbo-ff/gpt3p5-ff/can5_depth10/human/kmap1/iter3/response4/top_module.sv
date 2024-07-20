module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Define internal wire signals
	wire w1, w2;
	
	// Define the truth table
	assign w1 = ~(a & b & c);
	assign w2 = (a & ~b & c) | (~a & ~b & c) | (~a & b & c) | (a & b & ~c);
	
	// Assign the output
	assign out = w1 | w2;

endmodule
