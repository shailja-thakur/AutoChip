module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Create intermediate wires
	wire w1, w2, w3;
	
	// Create the AND gates
	and gate1(w1, a, b);
	and gate2(w2, a, cin);
	and gate3(w3, b, cin);
	
	// Create the XOR gates
	xor gate4(sum, a, w2);
	xor gate5(sum, b, w3);
	xor gate6(sum, w1, w3);
	
	// Create the OR gate
	or gate7(cout, w1, w2, w3);
endmodule
