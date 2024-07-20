module top_module(
	input a, 
	input b,
	output out
);
	// OR gate to compute logical OR of inputs a and b
	assign or_out = a | b;
	
	// Inverter to negate the output of OR gate
	assign out = ~or_out;
endmodule
