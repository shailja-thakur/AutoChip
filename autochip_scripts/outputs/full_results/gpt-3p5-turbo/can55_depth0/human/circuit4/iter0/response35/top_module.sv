module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal wires
	wire w1, w2, w3, w4, w5;
	
	// And gates
	and #(4) and1 (
		.a(a),
		.b(b),
		.c(c),
		.d(d),
		.q(w1)
	);
	
	// Or gates
	or #(2) or1 (
		.a(w1),
		.b(w2),
		.q(w3)
	);
	
	or #(2) or2 (
		.a(w4),
		.b(w5),
		.q(q)
	);

	// Not gates
	not #(2) not1 (
		.a(w3),
		.q(w4)
	);

	not #(2) not2 (
		.a(w1),
		.q(w5)
	);
	
endmodule
