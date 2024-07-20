module top_module(
	input a, 
	input b,
	input c,
	output out
);
	
	// Assigning values based on Karnaugh map
	
	assign out = (a & b & c) | (!a & b & c) | (!a & b & !c) | (a & b & !c) | (!a & !b & c) | (a & !b & c) | (a & !b & !c) | (a & b & c);

endmodule
