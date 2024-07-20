module top_module (
	input a, 
	input b, 
	output q
);

	// Define internal wire
	wire w1;

	// Define AND gate
	and gate1 (
		.a(a),
		.b(b),
		.z(w1)
	);

	// Define NOT gate
	not gate2 (
		.a(w1),
		.z(q)
	);

endmodule
