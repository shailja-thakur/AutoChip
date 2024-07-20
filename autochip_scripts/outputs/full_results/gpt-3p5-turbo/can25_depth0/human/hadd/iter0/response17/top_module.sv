module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Define internal wires
	wire sum_wire;
	wire cout_wire;

	// Create half adder logic
	xor(sum_wire, a, b);
	and(cout_wire, a, b);

	// Assign output signals
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
