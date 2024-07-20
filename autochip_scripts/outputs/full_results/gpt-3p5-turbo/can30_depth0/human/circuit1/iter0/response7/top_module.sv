module top_module (
	input a, 
	input b, 
	output q
);
	
	assign q = a & ~b;  // The circuit performs the logical AND between the input a and the negation (~) of input b, and assigns the result to output q.
	
endmodule
