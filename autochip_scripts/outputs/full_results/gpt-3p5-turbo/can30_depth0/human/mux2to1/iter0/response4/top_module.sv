module top_module (
	input a,
	input b,
	input sel,
	output out
);
	
	assign out = sel ? b : a;   // Use ternary operator to implement the 2-to-1 multiplexer
	                            
endmodule
