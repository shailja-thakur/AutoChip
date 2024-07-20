module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Declare the wire for the output
	wire out;
	
	// Instantiate the multiplexer
	mux M1(a, b, sel, out);
	
	// Define the multiplexer module
	module mux (
		input a,
		input b,
		input sel,
		output out
	);
		assign out = sel ? b : a;
	endmodule
