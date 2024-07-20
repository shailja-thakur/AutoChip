module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Internal wires to connect the gates
	wire and1_output;
	wire and2_output;
	wire and3_output;
	wire and4_output;
	wire or1_output;
	wire or2_output;
	
	// AND gates
	and and1 (
		.a(p1a),
		.b(p1b),
		.c(p1c),
		.z(and1_output)
	);
	and and2 (
		.a(p1d),
		.b(p1e),
		.c(p1f),
		.z(and2_output)
	);
	and and3 (
		.a(p2a),
		.b(p2b),
		.z(and3_output)
	);
	and and4 (
		.a(p2c),
		.b(p2d),
		.z(and4_output)
	);
	
	// OR gates
	or or1 (
		.a(and1_output),
		.b(and2_output),
		.z(or1_output)
	);
	or or2 (
		.a(and3_output),
		.b(and4_output),
		.z(or2_output)
	);
	
	// Output assignments
	assign p1y = or1_output;
	assign p2y = or2_output;

endmodule
