module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Define internal wires
	wire s1, s2, c1, c2;

	// Instantiate XOR gates
	xor_gate xor1 (.a(a), .b(b), .z(s1));
	xor_gate xor2 (.a(s1), .b(cin), .z(sum));

	// Instantiate AND gates
	and_gate and1 (.a(a), .b(b), .z(c1));
	and_gate and2 (.a(a), .b(cin), .z(c2));
	and_gate and3 (.a(b), .b(cin), .z(cout));

	// Instantiate OR gate
	or_gate or1 (.a(c1), .b(c2), .z(cout));
endmodule
