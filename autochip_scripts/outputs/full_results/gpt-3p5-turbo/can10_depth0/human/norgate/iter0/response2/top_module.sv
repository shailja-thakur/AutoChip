module top_module(
	input a, 
	input b,
	output out
);
	
	// Internal wires
	wire n1;

	// NOR gate instance
	nor_gate nor1(
		.a(a),
		.b(b),
		.out(n1)
	);

	// Inverter instance
	inverter inv1(
		.a(n1),
		.out(out)
	);

endmodule
module nor_gate(
	input a,
	input b,
	output out
);
	
	assign out = ~(a | b);

endmodule
module inverter(
	input a,
	output out
);
	
	assign out = ~a;

endmodule
