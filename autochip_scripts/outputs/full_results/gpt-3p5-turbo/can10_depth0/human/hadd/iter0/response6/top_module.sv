module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire sum_wire;
	wire cout_wire;

	// Instantiate the half adder module
	half_adder ha (
		.a(a),
		.b(b),
		.sum(sum_wire),
		.cout(cout_wire)
	);

	// Assign outputs to the wires
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Logic for sum and carry out
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
