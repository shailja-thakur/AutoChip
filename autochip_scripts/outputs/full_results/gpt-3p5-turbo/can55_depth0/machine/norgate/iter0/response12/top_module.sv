module top_module(
	input a, 
	input b,
	output out
);
	
	// Implement the logic gate with an OR gate and an inverter
	assign out = ~(a | b);

endmodule
