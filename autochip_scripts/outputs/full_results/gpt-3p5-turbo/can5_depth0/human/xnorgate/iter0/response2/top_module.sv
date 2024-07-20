module top_module(
		input a, 
		input b,
		output out
	);
	
	// Implementing XNOR gate
	assign out = ~(a ^ b);
	
endmodule
