module top_module(
	input a, 
	input b,
	input c,
	output out
);

wire w1, w2;

and #(4) and1(w1, a, b, c);
and #(4) and2(w2, a, b, c);

or #(2) or1(out, w1, w2);

endmodule
