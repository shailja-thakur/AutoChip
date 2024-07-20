module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// declare internal wire
	wire mux_out;

	// instantiate the multiplexer
	multiplexer mux (
		.a(a),
		.b(b),
		.sel(sel),
		.out(mux_out)
	);

	// assign the output of the multiplexer to the module output
	assign out = mux_out;

endmodule
module multiplexer (
	input a,
	input b,
	input sel,
	output out
);

	// logic for the multiplexer
	always @(*)
	begin
		if (sel == 1'b0)
		begin
			out = a;
		end
		else
		begin
			out = b;
		end
	end

endmodule
