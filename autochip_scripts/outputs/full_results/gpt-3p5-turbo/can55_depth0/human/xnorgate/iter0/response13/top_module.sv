module top_module(
	input a, 
	input b,
	output out
);
	
	assign out = ~(a ^ b);       // Implement XNOR using bitwise XOR and negation operator
	
endmodule
