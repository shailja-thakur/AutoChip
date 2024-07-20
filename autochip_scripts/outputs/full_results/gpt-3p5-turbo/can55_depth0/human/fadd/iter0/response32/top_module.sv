module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Assign intermediate signals
	wire s1, s2, c1, c2;
	
	// Create instances for the XOR gates
	xor_gate xor1(.a(a), .b(b), .out(s1));
	xor_gate xor2(.a(s1), .b(cin), .out(sum));
	
	// Create instances for the AND gates
	and_gate and1(.a(a), .b(b), .out(c1));
	and_gate and2(.a(s1), .b(cin), .out(c2));
	
	// Create instances for the OR gate
	or_gate or1(.a(c1), .b(c2), .out(cout));

endmodule
