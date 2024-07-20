module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Wire declarations
wire ab_or, cd_or;

// OR gates for inputs a and b, and inputs c and d
or gate_ab(
	.a(a),
	.b(b),
	.q(ab_or)
);

or gate_cd(
	.a(c),
	.b(d),
	.q(cd_or)
);

// AND gate for outputs ab_or and cd_or
and gate_q(
	.a(ab_or),
	.b(cd_or),
	.q(q)
);

endmodule
