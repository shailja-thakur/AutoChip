module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Declaration of internal wire
	wire mux_out;

	// MUX implementation using conditional expression
	assign mux_out = (sel) ? b : a;

	// Assigning the output value of mux_out wire
	assign out = mux_out;

endmodule
