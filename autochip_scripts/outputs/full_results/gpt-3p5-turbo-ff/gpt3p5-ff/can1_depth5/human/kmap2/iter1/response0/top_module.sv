module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4, w5, w6;

and gate1 (
	.w1,
	.a(a),
	.b(~b)
);

or gate2 (
	.w2,
	.a(c),
	.b(~d)
);

and gate3 (
	.w3,
	.a(~a),
	.b(b)
);

or gate4 (
	.w4,
	.a(c),
	.b(~d)
);

and gate5 (
	.w5,
	.a(a),
	.b(b)
);

and gate6 (
	.w6,
	.a(~c),
	.b(d)
);

or gate7 (
	.out,
	.a(w1),
	.b(~w2),
	.c(~w3),
	.d(w4),
	.e(w5),
	.f(w6)
);

endmodule
