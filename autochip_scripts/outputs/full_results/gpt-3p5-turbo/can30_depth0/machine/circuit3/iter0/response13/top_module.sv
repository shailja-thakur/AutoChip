module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// bitwise OR of inputs a and b
	wire ab_or;
	or #(1) or_ab (
		.a(a),
		.b(b),
		.z(ab_or)
	);

	// bitwise OR of inputs c and d
	wire cd_or;
	or #(1) or_cd (
		.a(c),
		.b(d),
		.z(cd_or)
	);

	// bitwise AND of ab_or and cd_or
	and #(1) and_abcd (
		.a(ab_or),
		.b(cd_or),
		.z(q)
	);

endmodule
