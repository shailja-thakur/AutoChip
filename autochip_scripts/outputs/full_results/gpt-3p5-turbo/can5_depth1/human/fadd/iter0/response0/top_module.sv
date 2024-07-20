module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wires and registers
	wire s1, s2;
	wire c1, c2;

	// Implement the full adder functionality
	// Generate sum bit
	xor_gate x1 (.a(a), .b(b), .y(s1));
	xor_gate x2 (.a(s1), .b(cin), .y(sum));

	// Generate carry bit
	and_gate a1 (.a(a), .b(b), .y(c1));
	and_gate a2 (.a(s1), .b(cin), .y(c2));
	or_gate o1 (.a(c1), .b(c2), .y(cout));

endmodule
