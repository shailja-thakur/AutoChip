module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Intermediate signals
	wire w1, w2, w3;

	// Implementing the circuit using gates
	and gate_and1(w1, a, ~b);
	and gate_and2(w2, ~a, b);
	and gate_and3(w3, c, b);
	or gate_or(out, w1, w2, w3);
	
endmodule
