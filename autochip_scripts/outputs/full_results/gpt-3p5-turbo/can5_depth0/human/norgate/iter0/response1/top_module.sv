module top_module(
	input a, 
	input b,
	output out
);
	// Assign the output based on the NOR operation of inputs a and b
	assign out = ~(a | b);
endmodule
