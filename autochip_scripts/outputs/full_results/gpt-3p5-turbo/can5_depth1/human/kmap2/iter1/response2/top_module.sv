module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define internal signals
wire w1, w2, w3, w4;

// Implement the circuit
and gate1(w1, !a, b, !c, d);
and gate2(w2, !a, !b, c, d);
and gate3(w3, !a, !b, !c, d);
and gate4(w4, a, b, c, d);

or gate5(out, w1, w2, w3, w4);

endmodule
