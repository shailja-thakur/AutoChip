module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Define internal wires and signals
	wire mux_output;

	// Create the 2-to-1 multiplexer
	assign mux_output = (sel == 1'b0) ? a : b;
	
	// Output the multiplexer result
	assign out = mux_output;

endmodule
