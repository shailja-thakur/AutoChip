module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implement the truth table using a Karnaugh map
	
	// Karnaugh map layout:
	//        ab
	// cd   00 01 11 10
	//  00 | 1 | 1 | 0 | 1 |
	//  01 | 1 | 0 | 0 | 1 |
	//  11 | 0 | 1 | 1 | 1 |
	//  10 | 1 | 1 | 0 | 0 |
	
	// Implementing the Karnaugh map, we get the following boolean expression:
	
	// out = a'b'cd + a'b'cd + ab'cd + a'bc'd + abcd + ab'cd + abc'd 
	
	// Simplifying the boolean expression, we get:
	
	// out = a'b'cd + ab'cd + abc'd + abcd
	
	assign out = (a && !b && !c && d) || (!a && b && !c && d) || (a && b && !c && !d) || (a && b && c && d);
	
endmodule
