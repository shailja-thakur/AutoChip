module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4, w5, w6, w7, w8;

// Karnaugh map implementation
and(w1, a, b);
and(w2, a, b, !c);
and(w3, a, !b, c);
and(w4, a, !b, d);
and(w5, !a, !b, c);
and(w6, !a, b, d);
and(w7, !a, b, !c);
and(w8, !a, !b, !c, d);

or(out, w1, w2, w3, w4, w5, w6, w7, w8);

endmodule
