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

	// Intermediate wire outputs for AND gates.
	wire p1_and_out, p2_and_out;

	// Logic gate for p1y output.
	and #(
		4,  // Specify the number of inputs for the AND gate
		1   // Specify the output width
	) p1_and_gate(
		.p(p1a),
		.p(p1b),
		.p(p1c),
		.p(p1d),
		.y(p1_and_out)
	);

	// Logic gate for p2y output.
	and #(
		4,  // Specify the number of inputs for the AND gate
		1   // Specify the output width
	) p2_and_gate(
		.p(p2a),
		.p(p2b),
		.p(p2c),
		.p(p2d),
		.y(p2_and_out)
	);

	// Invert the outputs.
	assign p1y = ~p1_and_out;
	assign p2y = ~p2_and_out;

endmodule
