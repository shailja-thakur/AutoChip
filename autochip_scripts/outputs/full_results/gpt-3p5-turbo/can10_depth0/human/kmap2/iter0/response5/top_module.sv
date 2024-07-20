module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4;

and gate1 (w1, a, ~c);
and gate2 (w2, ~a, b, ~c);
and gate3 (w3, ~b, c, ~d);
and gate4 (w4, a, b, d);

or gate5 (out, w1, w2, w3, w4);

endmodule
