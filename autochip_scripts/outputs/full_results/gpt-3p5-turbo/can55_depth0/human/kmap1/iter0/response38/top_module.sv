module top_module(
	input a, 
	input b,
	input c,
	output out
);

wire w1, w2, w3;
and gate1(w1, a, b);
and gate2(w2, b, c);
and gate3(w3, a, c);
or gate4(out, w1, w2, w3);

endmodule
