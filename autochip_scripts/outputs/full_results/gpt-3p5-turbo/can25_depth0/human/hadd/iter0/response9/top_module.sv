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
	half_adder HA1(
		.a(a),
		.b(b),
		.sum(sum_wire),
		.cout(cout_wire)
	);

	// Assign the outputs of the half adder to the outputs of the top module
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire xor_out;
	wire and_out;

	// Implement XOR and AND gates
	xor XOR1(
		.a(a),
		.b(b),
		.out(xor_out)
	);

	and AND1(
		.a(a),
		.b(b),
		.out(and_out)
	);

	// Generate sum and carry-out
	assign sum = xor_out;
	assign cout = and_out;

endmodule
