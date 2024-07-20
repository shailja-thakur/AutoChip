module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4, w5, w6;

and gate1 (w1, a, b);
and gate2 (w2, c, d);
or gate3 (w3, w1, w2);

and gate4 (w4, a, b);
not gate5 (w5, c);
and gate6 (w6, gate5.out, d);
or gate7 (w7, w4, w6);

not gate8 (out, gate3.out);

endmodule
