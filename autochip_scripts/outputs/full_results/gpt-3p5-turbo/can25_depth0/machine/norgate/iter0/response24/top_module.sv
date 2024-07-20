module top_module(
	input a, 
	input b,
	output out
);
	
	/* OR gate */
	wire or_output;
	or_gate or1(
		.a(a),
		.b(b),
		.out(or_output)
	);

	/* Inverter */
	inverter inv1(
		.a(or_output),
		.out(out)
	);
	
endmodule
module or_gate(
	input a,
	input b,
	output out
);
	
	assign out = a | b;
	
endmodule
module inverter(
	input a,
	output out
);
	
	assign out = ~a;
	
endmodule
