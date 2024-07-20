module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3;

and gate1 (w1, a, b);
and gate2 (w2, c, d);
and gate3 (w3, a, d);
xor gate4 (out, w1, w2);
or gate5 (out, out, w3);

endmodule
