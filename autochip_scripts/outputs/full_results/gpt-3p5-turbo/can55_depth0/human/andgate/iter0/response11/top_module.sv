module top_module(
	input a, 
	input b,
	output out
);
	
	and gates(
		.a(a),
		.b(b),
		.out(out)
	);
	
endmodule
