module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire ab_or, cd_or;

or gate_ab (
	.ab(ab_or),
	.a(a),
	.b(b)
);

or gate_cd (
	.cd(cd_or),
	.c(c),
	.d(d)
);

and gate_q (
	.q(q),
	.a(ab_or),
	.b(cd_or)
);

endmodule
