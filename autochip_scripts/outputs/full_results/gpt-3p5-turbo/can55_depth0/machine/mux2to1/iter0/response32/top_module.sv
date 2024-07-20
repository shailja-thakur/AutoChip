module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// wire for connecting the inputs and outputs
	wire mux_out;

	// multiplexer implementation
	assign mux_out = sel ? b : a;

	// assign the output of the multiplexer to the output of the module
	assign out = mux_out;

endmodule
