module top_module (
	input a,
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4;

andgate a1(w1, a, ~b);
andgate a2(w2, ~c, d);
andgate a3(w3, b, ~d);
andgate a4(w4, ~a, c);

orgate o1(out, w1, w2, w3, w4);

endmodule
