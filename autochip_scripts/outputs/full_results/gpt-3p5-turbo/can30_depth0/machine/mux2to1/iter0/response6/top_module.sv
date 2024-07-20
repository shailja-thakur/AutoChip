module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Declare wire for the output
	wire mux_output;

	// Instantiate the multiplexer module
	mux2to1 mux_inst (
		.a(a),
		.b(b),
		.sel(sel),
		.out(mux_output)
	);

	// Assign the output of the multiplexer to the module output
	assign out = mux_output;

endmodule
module mux2to1 (
	input a,
	input b,
	input sel,
	output out
);
	
	// Logic to select between inputs a and b based on the value of sel
	assign out = (sel == 1'b0) ? a : b;

endmodule
