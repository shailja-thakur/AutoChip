module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Internal wires
	wire sum_int, cout_int;
	
	// Instantiate the half adder module
	half_adder ha (
		.a(a),
		.b(b),
		.sum(sum_int),
		.cout(cout_int)
	);
	
	// Assign the outputs
	assign sum = sum_int;
	assign cout = cout_int;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	assign sum = a ^ b;
	assign cout = a & b;

endmodule
