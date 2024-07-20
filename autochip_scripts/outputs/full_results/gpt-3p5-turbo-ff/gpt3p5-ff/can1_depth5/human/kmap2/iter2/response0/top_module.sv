module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4, w5, w6;

and gate1 (
	.a(a),
	.b(~b),
	.w(w1)
);

or gate2 (
	.a(c),
	.b(~d),
	.w(w2)
);

and gate3 (
	.a(~a),
	.b(b),
	.w(w3)
);

or gate4 (
	.a(c),
	.b(~d),
	.w(w4)
);

and gate5 (
	.a(a),
	.b(b),
	.w(w5)
);

and gate6 (
	.a(~c),
	.b(d),
	.w(w6)
);

or gate7 (
	.a(w1),
	.b(~w2),
	.c(~w3),
	.d(w4),
	.e(w5),
	.f(w6),
	.out(out)
);

endmodule
