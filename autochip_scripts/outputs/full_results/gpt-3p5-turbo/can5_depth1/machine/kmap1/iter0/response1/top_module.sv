module top_module(
	input a, 
	input b,
	input c,
	output out
);
	
	// Perform the logical OR operation on the inputs
	assign out = a | b | c;
	
endmodule
