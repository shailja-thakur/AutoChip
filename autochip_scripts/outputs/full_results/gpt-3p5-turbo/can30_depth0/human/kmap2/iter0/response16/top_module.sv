module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w0, w1, w2, w3, w4, w5, w6, w7;

and #(7) g1 (
	a,
	~b,
	~c,
	d,
	w0
);

and #(7) g2 (
	~a,
	~b,
	~c,
	~d,
	w1
);

and #(7) g3 (
	~a,
	~b,
	c,
	d,
	w2
);

and #(7) g4 (
	a,
	b,
	~c,
	d,
	w3
);

or #(8) g5 (
	w0,
	w1,
	w2,
	w3,
	w4
);

and #(7) g6 (
	~a,
	b,
	~c,
	d,
	w5
);

and #(7) g7 (
	a,
	b,
	c,
	d,
	w6
);

and #(7) g8 (
	a,
	b,
	~c,
	~d,
	w7
);

or #(8) g9 (
	w5,
	w6,
	w7,
	w4,
	out
);

endmodule
