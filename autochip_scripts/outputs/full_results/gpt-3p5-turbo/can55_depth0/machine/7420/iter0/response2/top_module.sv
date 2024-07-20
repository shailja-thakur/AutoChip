module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Internal wires
	wire and_output_p1;
	wire and_output_p2;

	// 4-input AND gates
	and #(4) and_p1 (
		.p({p1a, p1b, p1c, p1d}),
		.out(and_output_p1)
	);

	and #(4) and_p2 (
		.p({p2a, p2b, p2c, p2d}),
		.out(and_output_p2)
	);

	// Inverters
	not #() not_output_p1 (
		.in(and_output_p1),
		.out(p1y)
	);

	not #() not_output_p2 (
		.in(and_output_p2),
		.out(p2y)
	);

endmodule
