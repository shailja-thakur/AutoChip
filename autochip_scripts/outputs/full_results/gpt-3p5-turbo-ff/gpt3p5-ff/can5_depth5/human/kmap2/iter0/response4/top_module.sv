module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	wire w1, w2, w3, w4, w5, w6;
	and(w1, a, c);
	and(w2, a, d);
	and(w3, b, c);
	and(w4, b, d);
	and(w5, w1, w3);
	and(w6, w2, w4);
	or(out, w5, w6);
	
endmodule
