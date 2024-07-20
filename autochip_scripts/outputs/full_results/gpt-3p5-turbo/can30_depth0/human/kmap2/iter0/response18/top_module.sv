module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Intermediate signals
wire w1, w2, w3, w4, w5, w6, w7, w8;

// Implement 4-input AND gates
and and1 (w1, a, b, c, d);
and and2 (w2, a, b, c, d);
and and3 (w3, a, b, c, d);
and and4 (w4, a, b, c, d);
and and5 (w5, a, b, c, d);
and and6 (w6, a, b, c, d);
and and7 (w7, a, b, c, d);
and and8 (w8, a, b, c, d);

// Implement 4-input OR gates
or or1 (out, w1, w2, w3, w4);
or or2 (out, w5, w6, w7, w8);

endmodule
