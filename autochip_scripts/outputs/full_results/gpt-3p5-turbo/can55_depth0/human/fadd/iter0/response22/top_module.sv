module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
	// Create internal wires for intermediate calculations
	wire and1, and2, and3, and4; // AND gates input wires
	wire xor1, xor2, xor3; // XOR gates input wires

	// AND gates for generating carry-out (cout)
	and (and1, a, b);
	and (and2, a, cin);
	and (and3, b, cin);
	and (and4, and1, and2, and3); // AND gate for generating carry-out 

	// XOR gates for generating sum
	xor (xor1, a, b);
	xor (xor2, xor1, cin);
	xor (sum, xor2, cin); // sum = a XOR b XOR cin

	// Output signals
	assign cout = and4;
endmodule
