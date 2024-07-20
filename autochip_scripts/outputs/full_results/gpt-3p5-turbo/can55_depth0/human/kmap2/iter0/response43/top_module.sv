module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3;

not gate1 (a, w1);
not gate2 (b, w2);
not gate3 (c, w3);

or gate4 (w1, w2, w3, d, out);

endmodule
