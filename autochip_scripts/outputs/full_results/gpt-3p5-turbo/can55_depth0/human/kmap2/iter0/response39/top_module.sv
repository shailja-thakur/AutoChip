module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Intermediate signals
wire w1, w2;

// Logic gates
not #(2) n1(d, w1);
and #(2) a1(a, b, w2);
and #(2) a2(c, d, w2);
or #(4) o1(w1, w2, w1, w2, out);

endmodule
