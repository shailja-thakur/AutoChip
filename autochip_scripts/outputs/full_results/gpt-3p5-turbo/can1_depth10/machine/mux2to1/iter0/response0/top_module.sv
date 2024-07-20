module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Declare internal wires
	wire mux_out;
	
	// Instantiate the multiplexer
	mux_2to1 u1 (
		.a(a),
		.b(b),
		.sel(sel),
		.out(mux_out)
	);
	
	// Assign the output of the multiplexer to the output of the top module
	assign out = mux_out;

endmodule
module mux_2to1 (
	input a,
	input b,
	input sel,
	output reg out
);
	always @(*)
	begin
		if (sel == 1'b0)
			out = a;
		else
			out = b;
	end
endmodule
