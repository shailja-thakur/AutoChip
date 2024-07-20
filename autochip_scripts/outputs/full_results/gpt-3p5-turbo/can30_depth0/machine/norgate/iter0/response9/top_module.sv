module top_module(
	input a, 
	input b,
	output out
);

	// Define the internal signal for the output of the OR gate
	wire or_output;
	
	// Logic for OR gate
	assign or_output = a | b;
	
	// Logic for inverter
	assign out = ~or_output;
	
endmodule
