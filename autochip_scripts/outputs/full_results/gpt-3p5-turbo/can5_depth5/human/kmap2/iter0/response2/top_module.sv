module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
); 

wire w1, w2, w3, w4, w5, w6, w7, w8;

and_gates #(.width(8)) and1 (
	.a(a), 
	.b(b), 
	.out(w1)
);

and_gates #(.width(8)) and2 (
	.a(c), 
	.b(d), 
	.out(w2)
);

or_gates #(.width(8)) or1 (
	.a(w1),
	.b(w2),
	.out(w3)
);

and_gates #(.width(8)) and3 (
	.a(~a),
	.b(~b),
	.out(w4)
);

and_gates #(.width(8)) and4 (
	.a(~c),
	.b(d),
	.out(w5)
);

and_gates #(.width(8)) and5 (
	.a(a),
	.b(~b),
	.out(w6)
);

and_gates #(.width(8)) and6 (
	.a(c),
	.b(~d),
	.out(w7)
);

and_gates #(.width(8)) and7 (
	.a(~a),
	.b(~b),
	.out(w8)
);

or_gates #(.width(8)) or2 (
	.a(w4),
	.b(w5),
	.out(w9)
);

or_gates #(.width(8)) or3 (
	.a(w6),
	.b(w7),
	.out(w10)
);

or_gates #(.width(8)) or4 (
	.a(w8),
	.b(~(w9 | w10)),
	.out(out)
);
endmodule
