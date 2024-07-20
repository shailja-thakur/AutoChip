module top_module(
	input a, 
	input b,
	input c,
	output out
);
	// Intermediate signals
	wire w1, w2, w3, w4;

	// Logic gates
	and_gate and1(w1, a, b);
	or_gate or1(w2, a, b);
	or_gate or2(w3, w1, c);
	or_gate or3(w4, w2, c);
	or_gate or4(out, w3, w4);
endmodule
module and_gate(
	output out,
	input a,
	input b
);
	assign out = a & b;
endmodule
module or_gate(
	output out,
	input a,
	input b
);
	assign out = a | b;
endmodule
