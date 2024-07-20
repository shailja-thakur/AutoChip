module top_module(
	input a, 
	input b,
	output out
);

	// OR Gate
	wire or_result;
	assign or_result = a | b;
	
	// Inverter
	wire inv_result;
	assign inv_result = ~or_result;
	
	// Output
	assign out = inv_result;
	
endmodule
