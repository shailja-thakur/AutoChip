module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Intermediate signals
wire w1, w2, w3;

// Internal logic
and gate1(w1, a, b);
and gate2(w2, c, d);
and gate3(w3, w1, w2);
assign out = w3;

endmodule
