module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire sum_internal;
	wire cout_internal;

	// Instantiate the half adder module
	half_adder ha (
		.a(a),
		.b(b),
		.sum(sum_internal),
		.cout(cout_internal)
	);

	// Assign outputs
	assign sum = sum_internal;
	assign cout = cout_internal;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Declare internal wires
	wire sum_internal;
	wire cout_internal;

	// Generate sum and carry using XOR and AND gates
	assign sum_internal = a ^ b;
	assign cout_internal = a & b;

	// Assign outputs
	assign sum = sum_internal;
	assign cout = cout_internal;

endmodule
