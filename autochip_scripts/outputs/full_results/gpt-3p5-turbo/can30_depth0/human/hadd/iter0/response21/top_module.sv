module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire s, c;

	// Generate sum and carry-out using XOR and AND gates
	assign s = a ^ b;
	assign c = a & b;

	// Assign internal wires to output ports
	assign sum = s;
	assign cout = c;

endmodule
