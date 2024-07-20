module top_module(
	input x,
	input y,
	output z
);

wire a1,b1,a2,b2,z;

and_gate u1(
	.a(x),
	.b(y),
	.z(a1)
);

or_gate u2(
	.a(y),
	.b(x),
	.z(b1)
);

and_gate u3(
	.a(a1),
	.b(b1),
	.z(a2)
);

not_gate u4(
	.a(a2),
	.z(b2)
);

or_gate u5(
	.a(a2),
	.b(b2),
	.z(z)
);

endmodule
