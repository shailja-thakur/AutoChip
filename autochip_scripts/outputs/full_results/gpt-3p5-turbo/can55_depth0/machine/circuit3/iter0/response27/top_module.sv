module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Internal signals
	wire ab_or, cd_or;

	// OR gates
	or_gate or_ab(
		.a(a),
		.b(b),
		.q(ab_or)
	);
	
	or_gate or_cd(
		.a(c),
		.b(d),
		.q(cd_or)
	);

	// AND gate
	and_gate and_q(
		.a(ab_or),
		.b(cd_or),
		.q(q)
	);

endmodule
module or_gate (
	input a,
	input b,
	output q
);
	assign q = a | b;
endmodule
module and_gate (
	input a,
	input b,
	output q
);
	assign q = a & b;
endmodule
