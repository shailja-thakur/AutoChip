module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Internal wire for the multiplexer
	wire mux_out;

	// 2-to-1 multiplexer implementation
	assign mux_out = (sel == 0) ? a : b;

	// Assign the output of the multiplexer to the 'out' output port
	assign out = mux_out;

endmodule
