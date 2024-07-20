module top_module(
	input a, 
	input b,
	output out
);
	
	// Logic description
	assign out = ~(a ^ b);
	
endmodule
