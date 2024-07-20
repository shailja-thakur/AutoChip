module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Verilog code for a multiplexer
	// Using a ternary operator to select between a and b based on the value of sel
	assign out = (sel) ? b : a;
	
endmodule
