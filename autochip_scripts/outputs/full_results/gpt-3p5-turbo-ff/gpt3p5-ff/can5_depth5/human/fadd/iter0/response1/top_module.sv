module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Intermediate signals
	wire s1, c1, c2;
	
	// First XOR gate
	xor_gate xor1 (.a(a), .b(b), .o(s1));
	
	// Second XOR gate
	xor_gate xor2 (.a(s1), .b(cin), .o(sum));
	
	// First AND gate
	and_gate and1 (.a(a), .b(b), .o(c1));
	
	// Second AND gate
	and_gate and2 (.a(cin), .b(s1), .o(c2));
	
	// OR gate
	or_gate or1 (.a(c1), .b(c2), .o(cout));
endmodule
