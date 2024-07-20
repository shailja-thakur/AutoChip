module kmap_module (
	input a,
	input b,
	input c,
	input d,
	output out
);
 
	assign out = (a & ~b & ~c & ~d) | (a & ~b & c & ~d) | (~a & ~b & c & ~d) | (a & b & ~c & d) | (a & b & c & d) | (~a & b & c & ~d) | (a & ~b & c & d) | (~a & b & ~c & d);
 
endmodule
module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
 
	// instantiate the kmap module
	kmap_module kmap (
		.a(a),
		.b(b),
		.c(c),
		.d(d),
		.out(out)
	);
 
endmodule
