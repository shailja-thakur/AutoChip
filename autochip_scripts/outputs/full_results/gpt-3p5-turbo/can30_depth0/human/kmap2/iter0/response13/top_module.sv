module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13;

and gate1 (
	.a(a),
	.b(b),
	.z(m1)
);

not gate2 (
	.a(m1),
	.z(m2)
);

and gate3 (
	.a(c),
	.b(d),
	.z(m3)
);

not gate4 (
	.a(m3),
	.z(m4)
);

and gate5 (
	.a(a),
	.b(b),
	.z(m5)
);

and gate6 (
	.a(c),
	.b(d),
	.z(m6)
);

or gate7 (
	.a(m5),
	.b(m6),
	.z(m7)
);

or gate8 (
	.a(m2),
	.b(m4),
	.z(m8)
);

or gate9 (
	.a(m7),
	.b(m8),
	.z(m9)
);

not gate10 (
	.a(m9),
	.z(m10)
);

or gate11 (
	.a(m5),
	.b(m6),
	.z(m11)
);

and gate12 (
	.a(b),
	.b(c),
	.z(m12)
);

or gate13 (
	.a(m12),
	.b(m11),
	.z(m13)
);

not gate14 (
	.a(m13),
	.z(out)
);

endmodule
