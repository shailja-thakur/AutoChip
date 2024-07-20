module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Internal wires for intermediate signals
	wire sum_int;
	wire cout_int;
	
	// Instantiate the half-adder module
	half_adder HA(
		.a(a),
		.b(b),
		.sum(sum_int),
		.cout(cout_int)
	);

	// Primary outputs
	assign sum = sum_int;
	assign cout = cout_int;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Logic equations for sum and carry-out
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
