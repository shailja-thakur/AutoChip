module top_module(
	input a, 
	input b,
	output out
);
	// Declare internal wire
	wire or_out;
	
	// OR gate
	assign or_out = a | b;
	
	// Inverter
	assign out = ~or_out;
	
endmodule
