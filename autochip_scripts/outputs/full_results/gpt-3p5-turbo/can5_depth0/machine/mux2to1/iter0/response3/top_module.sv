module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Define internal wires
	wire mux_out;

	// Instantiate multiplexer
	mux2x1 mux(.a(a), .b(b), .sel(sel), .out(mux_out));

	// Assign output
	assign out = mux_out;

endmodule
