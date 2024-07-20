module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

	// Declare intermediate signals
	wire s1, s2, c1, c2;

	// Create half adder instances
	half_adder ha1(
		.a(a),
		.b(b),
		.sum(s1),
		.cout(c1)
	);

	half_adder ha2(
		.a(s1),
		.b(cin),
		.sum(sum),
		.cout(c2)
	);

	// Create OR gate instance
	or_gate og(
		.a(c1),
		.b(c2),
		.out(cout)
	);

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Declare intermediate signals
	wire w1, w2;
	
	// Create XOR gate instance
	xor_gate xg1(
		.a(a),
		.b(b),
		.out(w1)
	);

	// Create AND gate instance
	and_gate ag(
		.a(a),
		.b(b),
		.out(w2)
	);

	// Assign outputs
	assign sum = w1;
	assign cout = w2;

endmodule
module xor_gate (
	input a,
	input b,
	output out
);
	assign out = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output out
);
	assign out = a & b;
endmodule
module or_gate (
	input a,
	input b,
	output out
);
	assign out = a | b;
endmodule
