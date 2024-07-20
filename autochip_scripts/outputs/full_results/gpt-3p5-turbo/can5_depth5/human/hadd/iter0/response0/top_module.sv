module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Declare internal wires for the sum and carry-out
	wire sum_wire;
	wire cout_wire;

	// Create the half adder logic
	xor(sum_wire, a, b);
	and(cout_wire, a, b);

	// Assign the internal wires to the output ports
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
