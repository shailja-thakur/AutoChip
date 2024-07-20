module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Create internal wire variables
	wire w1, w2, w3, w4, w5, w6, w7, w8;
	
	// Implement the logic using gates and assign them to the wire variables
	and gate1(w1, a, b);
	and gate2(w2, c, d);
	and gate3(w3, a, c);
	and gate4(w4, b, d);
	or gate5(w5, w1, w2);
	or gate6(w6, w3, w4);
	or gate7(w7, w5, w6);
	and gate8(out, w7);
endmodule
