module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Create internal signals
wire w1, w2, w3, w4, w5, w6, w7, w8;

// Implement the circuit using logic gates
and gate1(w1, a, ~b, ~c, ~d);
and gate2(w2, ~a, ~b, ~c, d);
and gate3(w3, ~a, b, ~c, d);
and gate4(w4, ~a, b, c, ~d);
and gate5(w5, a, b, ~c, d);
and gate6(w6, a, b, c, ~d);
and gate7(w7, ~a, ~b, c, d);
and gate8(w8, a, ~b, c, d);

or sum(out, w1, w2, w3, w4, w5, w6, w7, w8);

endmodule
