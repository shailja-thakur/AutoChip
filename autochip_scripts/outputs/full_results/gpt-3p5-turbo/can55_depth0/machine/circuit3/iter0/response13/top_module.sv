module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Declare intermediate signals
	wire ab_or, cd_or;

	// OR gates
	or #(1) or_ab (
		.in1(a),
		.in2(b),
		.out(ab_or)
	);

	or #(1) or_cd (
		.in1(c),
		.in2(d),
		.out(cd_or)
	);

	// AND gate
	and #(1) and_q (
		.in1(ab_or),
		.in2(cd_or),
		.out(q)
	);
endmodule
