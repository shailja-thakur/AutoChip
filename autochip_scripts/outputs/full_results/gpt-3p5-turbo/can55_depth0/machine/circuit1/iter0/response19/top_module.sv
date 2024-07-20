module top_module (
	input a, 
	input b, 
	output q
);
	and gate1(
		.a(a),
		.b(b),
		.z(q)
	);
endmodule
