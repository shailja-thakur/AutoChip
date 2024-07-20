module xor_gate (
	input a,
	input b,
	output z
);
	
	assign z = a ^ b;
	
endmodule
module not_gate (
	input a,
	output z
);
	
	assign z = ~a;
	
endmodule
module top_module (
	input a,
	input b,
	input c,
	input d,
	output q
);

	wire w1, w2, w3, w4;
	
	// Perform XOR operation on inputs a, b, c, and d
	xor_gate xor1 (
		.a(a),
		.b(b),
		.z(w1)
	);
	xor_gate xor2 (
		.a(w1),
		.b(c),
		.z(w2)
	);
	xor_gate xor3 (
		.a(w2),
		.b(d),
		.z(w3)
	);
	
	// Invert the result
	not_gate not1 (
		.a(w3),
		.z(q)
	);
	
endmodule
