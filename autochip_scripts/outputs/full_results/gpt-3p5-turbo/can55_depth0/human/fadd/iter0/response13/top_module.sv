module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Create intermediate signals
	wire w1, w2, w3;
	
	// Implement XOR gates
	xor_gate xor1(.a(a), .b(b), .out(w1));
	xor_gate xor2(.a(w1), .b(cin), .out(sum));
	
	// Implement AND gates
	and_gate and1(.a(a), .b(b), .out(w2));
	and_gate and2(.a(w1), .b(cin), .out(w3));
	
	// Implement OR gate
	or_gate or1(.a(w2), .b(w3), .out(cout));
	
endmodule
