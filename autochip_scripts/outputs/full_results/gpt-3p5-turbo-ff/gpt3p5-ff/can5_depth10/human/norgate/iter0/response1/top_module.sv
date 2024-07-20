module top_module(
	input a, 
	input b,
	output out
);

	// Define internal signals
	wire nor_out;
	
	// Implement NOR gate
	assign nor_out = ~(a | b);
	assign out = nor_out;
	
endmodule
