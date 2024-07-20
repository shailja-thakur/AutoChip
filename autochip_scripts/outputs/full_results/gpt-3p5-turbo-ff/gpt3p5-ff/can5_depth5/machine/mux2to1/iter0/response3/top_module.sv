module top_module (
	input wire a,
	input wire b,
	input wire sel,
	output wire out
);
	// Declare internal wire
	wire mux_out;
	
	// Instantiate a multiplexer
	mux_2to1 mux (.a(a), .b(b), .sel(sel), .out(mux_out));

	// Output the result of the multiplexer
	assign out = mux_out;

endmodule
module mux_2to1 (
	input wire a,
	input wire b,
	input wire sel,
	output wire out
);
	// Perform the 2-to-1 multiplexing
	assign out = sel ? b : a;

endmodule
