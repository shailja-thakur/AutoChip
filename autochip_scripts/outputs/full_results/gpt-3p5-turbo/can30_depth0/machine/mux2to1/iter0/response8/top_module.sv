module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Define the wire to connect the inputs to the output
	wire out_wire;

	// Instantiate the multiplexer module
	mux_module mux (
		.a(a),
		.b(b),
		.sel(sel),
		.out(out_wire)
	);

	// Assign the output wire to the output port of the top module
	assign out = out_wire;

endmodule
module mux_module (
	input a,
	input b,
	input sel,
	output reg out
);
	always @ (sel)
	begin
		if(sel == 1'b1)
			out = b;
		else if(sel == 1'b0)
			out = a;
	end
endmodule
