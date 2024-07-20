module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Define the signals and wires
	wire sum_wire;
	wire cout_wire;

	// Instantiate the half adder module
	half_adder HA1(
		.a(a),
		.b(b),
		.sum(sum_wire),
		.cout(cout_wire)
	);

	// Assign the signals to the outputs
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Intermediate signals and wires
	wire sum_wire;
	wire cout_wire;
	
	// Logic for calculating sum and carry-out
	xor(sum_wire, a, b);
	and(cout_wire, a, b);
	
	// Assign the signals to the outputs
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
