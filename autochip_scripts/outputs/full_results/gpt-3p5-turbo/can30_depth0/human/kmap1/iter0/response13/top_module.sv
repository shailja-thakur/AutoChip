module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Declare the internal signal
	wire a_and_b;
	
	// Implement the AND gate for inputs a and b
	assign a_and_b = a & b;
	
	// Implement the logic according to the Karnaugh map
	assign out = (a_and_b & c) | (!a & b & !c);

endmodule
