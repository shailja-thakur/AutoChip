module top_module(
	input a, 
	input b,
	output out
);
	
	// Implementation of the XOR gate
	assign out = ~(a ^ b);
	
endmodule
