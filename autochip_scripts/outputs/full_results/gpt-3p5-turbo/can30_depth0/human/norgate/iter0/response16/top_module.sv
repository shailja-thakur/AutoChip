module top_module(
	input a, 
	input b,
	output out
);

	// Define the NOR gate functionality
	assign out = ~(a | b);

endmodule
